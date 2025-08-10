# frozen_string_literal: true

module ERBLint
  module Tailwindcss
    module Linters
      # Linter for detecting and removing duplicate Tailwind CSS classes
      # This linter identifies duplicate classes within a class attribute
      # and provides autocorrect to remove duplicates.
      # Full implementation will be added in the next phase.
      class Duplicate
        # Configuration schema for the linter
        CONFIG_SCHEMA = {
          type: "object",
          properties: {
            dedupe_across_variants: {
              type: "boolean",
              default: false
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

        def autocorrect(_processed_source, _offense)
          # Autocorrect implementation will be added in the next phase
        end
      end
    end
  end
end
