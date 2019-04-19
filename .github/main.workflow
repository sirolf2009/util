workflow "Test Workflow" {
  on = "push"
  resolves = ["GitHub Action for Maven"]
}

action "GitHub Action for Maven" {
  uses = "docker://sirolf2009/docker-oraclejdk8-mvn-gpg:latest"
  args = "clean deploy -P release -Dgpg.passphrase=$GPGPASSWORD"
  secrets = ["GPGPASSWORD"]
}
