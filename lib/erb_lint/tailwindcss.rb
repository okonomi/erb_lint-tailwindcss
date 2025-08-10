# frozen_string_literal: true

require_relative "tailwindcss/version"

module ErbLint
  module Tailwindcss
    class Error < StandardError; end

    # Compatibility alias for the main ERBLint module
    # This ensures the gem works with both naming conventions
  end
end

# Load the main ERBLint::Tailwindcss implementation
require_relative "../erb_lint-tailwindcss"
