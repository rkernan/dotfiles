set -l progname pack
# from /usr/share/fish/completions/pacman.fish
set -l listinstalled "(pacman -Q | string replace ' ' \t)"
set -l listall "(__fish_print_packages)"
set -l listgroups "(pacman -Sg)\t'Package Group'"

set -l noopt 'not __fish_seen_subcommand_from clean deptree diff downgrade download firmware-upgrade hardcode-tray info install install-local list-deps list-explicit list-orphans lostfiles provides provides-what remove search search-local sync upgrade verify'

complete -c $progname -e
complete -c $progname -f

complete -c $progname -n "$noopt" -f -a clean -d "Clean the pacman cache"
complete -c $progname -n "$noopt" -f -a deptree -d "List dependency tree of a given package"
complete -c $progname -n "$noopt" -f -a diff -d "Clean up pacnew files"
complete -c $progname -n "$noopt" -f -a downgrade -d "Downgrade a package"
complete -c $progname -n "$noopt" -f -a download -d "Download a remote package"
complete -c $progname -n "$noopt" -f -a firmware-upgrade -d "Upgrade the system firmware"
complete -c $progname -n "$noopt" -f -a hardcode-tray -d "Apply icons using the hardcode-tray utility"
complete -c $progname -n "$noopt" -f -a info -d "Show info for a package or packages"
complete -c $progname -n "$noopt" -f -a install -d "Install a remote package"
complete -c $progname -n "$noopt" -f -a install-local -d "Install a local file"
complete -c $progname -n "$noopt" -f -a list-deps -d "List all packages intalled as dependencies"
complete -c $progname -n "$noopt" -f -a list-explicit -d "List all explicitly install packages"
complete -c $progname -n "$noopt" -f -a list-orphans -d "List all installed orphan packages"
complete -c $progname -n "$noopt" -f -a lostfiles -d "List all orphaned files not owned by a package"
complete -c $progname -n "$noopt" -f -a provides -d "Query which remote package provides a specified file"
complete -c $progname -n "$noopt" -f -a provides-what -d "List all files provided by the given package or all packages if none are specified"
complete -c $progname -n "$noopt" -f -a remove -d "Uninstall a local package"
complete -c $progname -n "$noopt" -f -a search -d "Search for the specified remote package or list all remote packages if none are specified"
complete -c $progname -n "$noopt" -f -a search-local -d "Search for the specified local package or list all local packages if none are specified"
complete -c $progname -n "$noopt" -f -a sync -d "Sync the package file database"
complete -c $progname -n "$noopt" -f -a upgrade -d "Update the specified packages or all packages if none are specified"
complete -c $progname -n "$noopt" -f -a verify -d "Validate the specified packages or all packages if none are specified"

complete -c $progname -n "__fish_seen_subcommand_from deptree downgrade remove search-local upgrade verify" -d 'Installed package' -xa "$listinstalled"
complete -c $progname -n "__fish_seen_subcommand_from info provides-what search" -d 'Package' -xa "$listall"
complete -c $progname -n "__fish_seen_subcommand_from download install" -xa "$listall $listgroups"
