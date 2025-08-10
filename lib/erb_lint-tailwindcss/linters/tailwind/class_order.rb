# frozen_string_literal: true

module ERBLint
  module Linters
    module Tailwind
      # Linter for enforcing Tailwind CSS class order
      # This linter checks that Tailwind CSS classes are ordered according to the
      # official prettier-plugin-tailwindcss ordering rules and provides autocorrect.
      # Full implementation will be added in the next phase.
      class ClassOrder
        # Configuration schema for the linter
        CONFIG_SCHEMA = {
          type: "object",
          properties: {
            order_preset: {
              type: "string",
              enum: ["tailwind-v4"],
              default: "tailwind-v4"
            },
            grouping: {
              type: "string",
              enum: %w[flat grouped],
              default: "flat"
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

        def autocorrect(processed_source, offense)
          # Autocorrect implementation will be added in the next phase
        end
      end
    end
  end
end
