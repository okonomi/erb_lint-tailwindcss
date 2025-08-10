# frozen_string_literal: true

module ERBLint
  module Tailwindcss
    module Support
      # Order table containing Tailwind CSS class ordering rules
      # Generated from prettier-plugin-tailwindcss to ensure compatibility
      class OrderTable
        # This constant will be populated by the order extraction script
        TAILWIND_CLASS_ORDER = {
          # Placeholder - will be replaced with actual order data
          # Structure: { pattern_regex => weight_integer }
        }.freeze

        # Variant order rules (e.g., hover:, sm:, dark:)
        VARIANT_ORDER = {
          # Placeholder - will be replaced with actual variant order data
          # Structure: { variant_name => weight_integer }
        }.freeze

        class << self
          # Gets the sort weight for a given class
          # @param class_name [String] The class name to analyze
          # @return [Integer] Sort weight (lower numbers come first)
          def get_class_weight(_class_name)
            # Implementation will search through TAILWIND_CLASS_ORDER patterns
            # For now, return a default weight
            1000
          end

          # Gets the sort weight for variant prefixes
          # @param variant [String] The variant name (without colon)
          # @return [Integer] Sort weight for the variant
          def get_variant_weight(variant)
            VARIANT_ORDER.fetch(variant, 1000)
          end

          # Loads order data from the generated table
          # This method will be called to update the constants with real data
          def load_order_data(order_data)
            # Implementation will be added when order extraction is ready
          end
        end
      end
    end
  end
end
