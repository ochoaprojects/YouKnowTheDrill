terraform {
  backend "remote" {
    organization = "YouKnowTheDrill"

    workspaces {
      name = "YouKnowTheDrill"
    }
  }
}
