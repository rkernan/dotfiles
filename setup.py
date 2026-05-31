#!/usr/bin/env python3
"""Deploy dotfiles using GNU Stow, with per-target install and health checks."""

import os
import shutil
import subprocess
from argparse import ArgumentParser
from contextlib import chdir
from enum import StrEnum
from pathlib import Path
from typing import cast


class TerminalCode(StrEnum):
    """ANSI escape codes for coloured terminal output."""

    RESET = "\033[0m"
    BOLD = "\033[1m"
    RED = "\033[91m"
    GREEN = "\033[92m"


def check_call(args: str | os.PathLike[str]) -> None:
    """Print and execute a shell command, raising on failure."""
    print(f"> {TerminalCode.BOLD}{args}{TerminalCode.RESET}")
    _ = subprocess.check_call(args, shell=True)


def print_header(values: object) -> None:
    """Print a bold section header."""
    print(
        f"{TerminalCode.BOLD}==> ",
        values,
        end=f"{TerminalCode.RESET}\n",
    )


class InstallTarget(StrEnum):
    """Available install targets, each mapped to a stow directory name."""

    CHECKHEALTH = "checkhealth"
    CLI = "cli"
    GUI = "gui"
    SYSTEM_ARCHLINUX = "system-archlinux"
    WORK = "work"
    WSL = "wsl"


def guess_target() -> set[InstallTarget]:
    """Auto-detect applicable targets from the current environment."""
    targets = {InstallTarget.CHECKHEALTH, InstallTarget.CLI}
    if shutil.which("pacman"):
        targets |= {InstallTarget.SYSTEM_ARCHLINUX}
    if os.environ.get("XDG_CURRENT_DESKTOP", None) is not None:
        targets |= {InstallTarget.GUI}
    if (Path.home() / ".work").exists():
        targets |= {InstallTarget.WORK}
    if shutil.which("wsl.exe"):
        targets |= {InstallTarget.WSL}
    return targets


REQUIRED_DIRECTORIES: frozenset[Path] = frozenset(
    {
        Path.home() / ".config" / "git",
        Path.home() / ".local" / "bin",
        Path.home() / ".ssh",
    }
)


CONFIG_STUBS: frozenset[tuple[Path, str]] = frozenset(
    {
        (Path.home() / ".ssh" / "config.secure", "sshconfig"),
        (Path.home() / ".config" / "git" / "secure", "gitconfig"),
    }
)


def prepare_paths() -> None:
    """Create required directories and stub config files."""
    for path in REQUIRED_DIRECTORIES:
        path.mkdir(parents=True, exist_ok=True)
    for path, filetype in CONFIG_STUBS:
        if not path.exists():
            _ = path.write_text(f"# vi: ft={filetype}\n")


STOW_TARGETS: frozenset[InstallTarget] = frozenset(
    {
        InstallTarget.CLI,
        InstallTarget.GUI,
        InstallTarget.WORK,
        InstallTarget.WSL,
    }
)


def stow(*install: Path) -> None:
    """Run GNU stow to symlink the given directories into $HOME."""
    targets = " ".join([str(p) for p in install])
    check_call(f"stow --dotfiles -t {Path.home()} -vS {targets}")


def stow_targets(*targets: InstallTarget) -> None:
    """Stow every given target that is a member of *STOW_TARGETS*."""
    target_names: set[str] = set()
    target_paths: set[Path] = set()
    for target in targets:
        target_path = Path(".", target)
        if target in STOW_TARGETS:
            target_names |= {str(target)}
            target_paths |= {target_path}
    if target_names:
        print_header(f"stow {target_names}")
        stow(*target_paths)


def install_cli() -> set[str]:
    """Install CLI dev tools via uv and return their names for health checks."""
    checkhealth_bins: set[str] = set()
    print_header(InstallTarget.CLI)
    if shutil.which("uv"):
        for bin in (
            "basedpyright",
            "black",
            "isort",
            "pycodestyle",
            "pydocstyle",
        ):
            if not shutil.which(bin):
                check_call(f"uv tool install {bin}")
            checkhealth_bins |= {bin}
        check_call("uv tool upgrade --all")
        check_call("uv python upgrade")
    return checkhealth_bins


def install_gui() -> set[str]:
    """Set up GUI-specific config and return health-check bins."""
    print_header(InstallTarget.GUI)
    (Path.home() / ".config" / "environment.d").mkdir(parents=True, exist_ok=True)
    return {"btop", "opencode"}


def install_work() -> set[str]:
    """Set up work-specific config and return health-check bins."""
    print_header(InstallTarget.WORK)
    (Path.home() / ".work").touch()
    return {"groovy-language-server"}


def install_wsl() -> set[str]:
    """Configure WSL-specific dotfiles and fish environment."""
    print_header(InstallTarget.WSL)
    if shutil.which("fish"):
        check_call("fish -c 'set -U AUTOSTART_TMUX 1'")
        check_call("fish -c 'set -Ux GALLIUM_DRIVER d3d12'")
        check_call("fish -c 'set -Ux LIBVA_DRIVER_NAME d3d12'")
    userprofile = os.environ.get("USERPROFILE", None)
    if userprofile is not None:
        wezterm_config = Path(userprofile, ".config", "wezterm")
        shutil.rmtree(wezterm_config, ignore_errors=True)
        _ = shutil.copytree(
            Path("gui", "dot-config", "wezterm"),
            wezterm_config,
            dirs_exist_ok=True,
        )
    return set()


def install_system_archlinux() -> set[str]:
    """Apply system-wide Arch Linux config via rsync."""
    print_header(InstallTarget.SYSTEM_ARCHLINUX)
    if shutil.which("rsync"):
        check_call("run0 rsync -av system-archlinux/etc /etc")
    return set()


CHECKHEALTH_BINS: frozenset[str] = frozenset(
    {
        "bash-language-server",
        "bat",
        "cargo",
        "clangd",
        "fd",
        "fish",
        "fzf",
        "git-lfs",
        "go",
        "lua-language-server",
        "nvim",
        "pre-commit",
        "prettier",
        "rg",
        "rustup",
        "stow",
        "stylua",
        "tree-sitter",
        "uv",
        "vscode-json-language-server",
        "yaml-language-server",
        "zoxide",
    }
)


def checkhealth(*bins: str) -> None:
    """Check that each binary is on PATH, reporting OK or MISSING."""
    print_header(InstallTarget.CHECKHEALTH)
    for bin in sorted(bins):
        which = shutil.which(bin)
        if which:
            print(f"{TerminalCode.GREEN}OK{TerminalCode.RESET}", bin, "->", which)
        else:
            print(f"{TerminalCode.RED}MISSING{TerminalCode.RESET}", bin)


if __name__ == "__main__":
    parser = ArgumentParser()
    _ = parser.add_argument(
        "targets", type=InstallTarget, nargs="*", choices=list(InstallTarget)
    )
    _ = parser.add_argument("--system", action="store_true", dest="system_config")
    args = parser.parse_args()
    targets = cast(set[InstallTarget], args.targets)
    if not targets:
        targets = guess_target()
    with chdir(Path(__file__).parent):
        prepare_paths()
        stow_targets(*targets)
        checkhealth_bins: set[str] = set()
        checkhealth_bins |= CHECKHEALTH_BINS
        if InstallTarget.CLI in targets:
            checkhealth_bins |= install_cli()
        if InstallTarget.GUI in targets:
            checkhealth_bins |= install_gui()
        if InstallTarget.WORK in targets:
            checkhealth_bins |= install_work()
        if InstallTarget.WSL in targets:
            checkhealth_bins |= install_wsl()
        if InstallTarget.SYSTEM_ARCHLINUX in targets and cast(bool, args.system_config):
            checkhealth_bins |= install_system_archlinux()
        if InstallTarget.CHECKHEALTH in targets:
            checkhealth(*checkhealth_bins)
