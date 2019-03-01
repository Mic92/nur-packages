workflow "New workflow" {
  on = "push"
  resolves = ["docker://lnl7/nix"]
}

action "docker://lnl7/nix" {
  uses = "docker://lnl7/nix"
  args = "nix-env -f default.nix -qaP *"
}
