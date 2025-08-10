# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Ruby gem project that provides ERB linting functionality specifically for Tailwind CSS. The gem follows standard Ruby gem conventions:

- **Main module**: `ErbLint::Tailwindcss` defined in `lib/erb_lint/tailwindcss.rb`
- **Namespace structure**: The gem extends ERB Lint with Tailwind CSS-specific functionality
- **Entry point**: `lib/erb_lint/tailwindcss.rb` (currently skeletal with placeholder comment)
- **Version management**: Version defined in `lib/erb_lint/tailwindcss/version.rb`
- **Type definitions**: RBS signatures in `sig/erb_lint/tailwindcss.rbs`

## Development Commands

### Setup
```bash
bin/setup          # Install dependencies
```

### Testing
```bash
rake spec          # Run RSpec tests
bundle exec rspec  # Run tests directly with bundler
```

### Code Quality
```bash
rake rubocop       # Run RuboCop linter
rubocop            # Run RuboCop directly
rake               # Run default task (spec + rubocop)
```

### Development Console
```bash
bin/console        # Start IRB console with gem loaded
```

### Gem Management
```bash
bundle exec rake install  # Install gem locally
bundle exec rake release  # Release new version (updates version, creates git tag, pushes to rubygems.org)
```

## Documentation

- **`docs/sow.md`**: Project Statement of Work with detailed requirements, scope, and implementation specifications
- **`docs/plan.md`**: Development plan with 4-week MVP schedule and technical approach details

## Project Structure

The gem is currently in early development stage with basic scaffolding:
- Tests are minimal (placeholder test exists in `spec/erb_lint/tailwindcss_spec.rb`)
- Main functionality is not yet implemented
- Standard Ruby gem file structure with `lib/`, `spec/`, `bin/` directories
- Uses RSpec for testing and RuboCop for linting