terraform {
  required_version = ">= 0.15"
  required_providers {
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }
    archive = {
      source = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

variable "num_files" {
  default = 100
  type = number

  validation {
    condition = var.num_files >= 10
    error_message = "the length of the num_files should be more than 10 or equal"
  }
}

resource "random_shuffle" "random_nouns" {
    count = var.num_files
    input = local.uppercase_words["nouns"]
}

resource "random_shuffle" "random_adjectives" {
    count = var.num_files
    input = local.uppercase_words["adjectives"]
}

resource "random_shuffle" "random_verbs" {
    count = var.num_files
    input = local.uppercase_words["verbs"]
}

resource "random_shuffle" "random_adverbs" {
    count = var.num_files
    input = local.uppercase_words["adverbs"]
}

resource "random_shuffle" "random_numbers" {
    count = var.num_files
    input = local.uppercase_words["numbers"]
}

resource "local_file" "mad_libs" {
  count = var.num_files
  filename = "madlibs/madlib-${count.index}.txt"
  content = templatefile(element(local.templates, count.index),{
    nouns = random_shuffle.random_nouns[count.index].result
    adjectives = random_shuffle.random_adjectives[count.index].result
    verbs = random_shuffle.random_verbs[count.index].result
    adverbs = random_shuffle.random_adverbs[count.index].result
    numbers = random_shuffle.random_numbers[count.index].result
  })
}

variable "words" {
  description = "a word pool to use for madlibs"
  type = object({
    nouns = list(string),
    adjectives = list(string),
    verbs = list(string),
    adverbs = list(string),
    numbers = list(number),
  })

validation {
    condition = length(var.words["nouns"]) >= 5
    error_message = "at least 5 nouns must be supplied"
  }
}

# output the result in the console
output "madlibs" {
    value = templatefile("${path.module}/templates/amir.txt",{
        nouns = local.uppercase_words["nouns"]
        adjectives = local.uppercase_words["adjectives"]
        verbs = local.uppercase_words["verbs"]
        adverbs = local.uppercase_words["adverbs"]
        numbers = local.uppercase_words["numbers"]
    })
}

# expression to uppercase the var.words entries
locals {
    uppercase_words = {for k, v in var.words : k => [for s in v : upper(s)]}
}

# a list of template files.
locals {
  templates = tolist(fileset(path.module, "templates/*.txt"))
}

data "archive_file" "mad_libs" {
  depends_on = [ local_file.mad_libs ]
  type = "zip"
  source_dir = "${path.module}/madlibs"
  output_path = "${path.cwd}/madlibs.zip"
}