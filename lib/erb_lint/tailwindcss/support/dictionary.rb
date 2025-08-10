# frozen_string_literal: true

module ERBLint
  module Tailwindcss
    module Support
      # Dictionary for Tailwind CSS class validation
      # Contains known classes, variants, and validation rules
      class Dictionary
        # Known Tailwind CSS classes (placeholder - will be populated from order extraction)
        KNOWN_CLASSES = Set.new([
                                  # Placeholder classes - will be replaced with actual data
                                ]).freeze

        # Known variants (placeholder - will be populated from order extraction)
        KNOWN_VARIANTS = Set.new(%w[
                                   hover focus active disabled
                                   sm md lg xl 2xl
                                   dark light
                                 ]).freeze

        class << self
          # Checks if a class is a known Tailwind CSS class
          # @param class_name [String] The class name to check
          # @return [Boolean] True if the class is known
          def known_class?(class_name)
            # Remove variants and important flag for checking
            base_class = extract_base_class(class_name)
            KNOWN_CLASSES.include?(base_class) || arbitrary_value?(base_class)
          end

          # Checks if a variant is known
          # @param variant [String] The variant name (without colon)
          # @return [Boolean] True if the variant is known
          def known_variant?(variant)
            KNOWN_VARIANTS.include?(variant)
          end

          # Checks if a class uses arbitrary values (e.g., w-[100px])
          # @param class_name [String] The class name to check
          # @return [Boolean] True if it's an arbitrary value class
          def arbitrary_value?(class_name)
            class_name.include?("[") && class_name.include?("]")
          end

          # Loads dictionary data from external source
          # This method will be called to update the constants with real data
          def load_dictionary_data(_dictionary_data)
            # Implementation will be added when order extraction is ready
          end

          private

          # Extracts the base class name by removing variants and important flag
          # @param class_name [String] The full class name
          # @return [String] The base class name
          def extract_base_class(class_name)
            # Remove important flag
            base = class_name.sub(/^!/, "")

            # Remove variants (everything before the last colon)
            base.split(":").last || base
          end
        end
      end
    end
  end
end
