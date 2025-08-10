# frozen_string_literal: true

module ERBLint
  module Tailwindcss
    module Linters
      # Linter for detecting unknown/invalid Tailwind CSS classes
      # This linter identifies classes that are not valid Tailwind CSS utilities
      # and reports them as violations (detection only, no autocorrect).
      # Full implementation will be added in the next phase.
      class Unknown
        # Configuration schema for the linter
        CONFIG_SCHEMA = {
          type: "object",
          properties: {
            allow_arbitrary_values: {
              type: "boolean",
              default: true
            },
            safelist: {
              type: "array",
              items: { type: "string" },
              default: []
            },
            plugins: {
              type: "array",
              items: { type: "string" },
              default: []
            }
          },
          additionalProperties: false
        }.freeze

        def initialize(_file_loader, config)
          @config = config
        end

        def run(_processed_source)
          # Implementation will be added in the next phase
          []
        end
      end
    end
  end
end
