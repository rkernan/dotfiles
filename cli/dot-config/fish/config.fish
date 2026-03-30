fish_add_path $HOME"/.local/bin"

set -x EDITOR nvim
set -x PAGER less

#=========================#
# interactive mode config #
#=========================#
status is-interactive || exit

set --global fish_key_bindings fish_hybrid_key_bindings

if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end
fundle plugin 'jorgebucaran/autopair.fish'
fundle plugin 'andreiborisov/sponge'
fundle init

abbr e $EDITOR
abbr p $PAGER

subcommand_abbr sudo e $EDITOR
subcommand_abbr sudo p $PAGER

abbr cp cp -i
abbr g git
abbr ln ln -i
abbr mv mv -i
abbr rm rm -i

subcommand_abbr git a add
subcommand_abbr git aa "add --all"
subcommand_abbr git amend "commit --amend"
subcommand_abbr git ap "add --patch"
subcommand_abbr git b branch
subcommand_abbr git ci commit
subcommand_abbr git co checkout
subcommand_abbr git cob "checkout -b"
subcommand_abbr git cp "cherry-pick"
subcommand_abbr git p push
subcommand_abbr git pu pull
subcommand_abbr git unstage "restore --staged"
