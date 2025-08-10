# frozen_string_literal: true

require_relative "lib/erb_lint/tailwindcss/version"

Gem::Specification.new do |spec|
  spec.name = "erb_lint-tailwindcss"
  spec.version = ErbLint::Tailwindcss::VERSION
  spec.authors = ["okonomi"]
  spec.email = ["okonomi@oknm.jp"]

  spec.summary = "ERB Lint plugin for Tailwind CSS class ordering, deduplication, and validation"
  spec.description = "A gem that provides ERB Lint rules for Tailwind CSS classes, " \
                     "including class ordering, duplicate detection, and unknown class validation " \
                     "with autocorrect support."
  spec.homepage = "https://github.com/okonomi/erb_lint-tailwindcss"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/okonomi/erb_lint-tailwindcss"
  spec.metadata["changelog_uri"] = "https://github.com/okonomi/erb_lint-tailwindcss/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "erb_lint", "~> 0.4"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
