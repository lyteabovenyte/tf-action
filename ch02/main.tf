terraform {
    required_version = ">=0.15"
    required_providers {
      local = {
        source = "hashicorp/local"
        version = "~> 2.0"
      }
    }
}

resource "local_file" "literature" {
    filename = "art_of_war.txt"
    content = <<-EOT
    Sun Tzu said: The art of war is of vital importance of the State.

    It is a matter of life and death.
    the art of war now contains another statzan :) at least we assume it is in this way.
    EOT
}