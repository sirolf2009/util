workflow "Test Workflow" {
  on = "push"
  resolves = ["GitHub Action for Maven"]
}

action "GitHub Action for Maven" {
  uses = "sirolf2009/action-maven-cli@master"
  args = "clean deploy -P release"
}
