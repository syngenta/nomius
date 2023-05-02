# frozen_string_literal: true

require_relative "lib/nomius/version"

Gem::Specification.new do |spec|
  spec.name = "nomius"
  spec.version = Nomius::VERSION
  spec.authors = ["Oleksii Leonov"]
  spec.email = ["oleksii.leonov@syngenta.com", "ospo@syngenta.com"]

  spec.summary = "Nomius — bulk domain & package name availability checker"
  spec.description = "Bulk domain & package name availability checker"
  spec.homepage = "https://github.com/syngenta/nomius"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "changelog_uri" => "https://github.com/syngenta/nomius/blob/main/CHANGELOG.md",
    "source_code_uri" => spec.homepage,
    "documentation_uri" => spec.homepage,
    "bug_tracker_uri" => "https://github.com/syngenta/nomius/issues",
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ spec/ .git .github .devcontainer])
    end
  end
  spec.bindir = "exe"
  spec.executables = ["nomius"]
  spec.extra_rdoc_files = ["LICENSE", "README.md"]

  spec.add_dependency "faraday", "< 3"
  spec.add_dependency "faraday-follow_redirects", "< 1"
  spec.add_dependency "faraday-retry", "< 3"
  spec.add_dependency "retriable", "< 4"
  spec.add_dependency "tty-option", "< 1"
  spec.add_dependency "tty-progressbar", "< 1"
  spec.add_dependency "tty-table", "< 1"
  spec.add_dependency "whois", "< 6"
  spec.add_dependency "whois-parser", "< 3"
end
