# frozen_string_literal: true

require_relative "tokenizer"
require_relative "order_table"
require_relative "dictionary"

module ERBLint
  module Tailwindcss
    module Support
      # Sorter for ordering Tailwind CSS classes according to official rules
      # Uses the generated order table to determine proper class sequence
      class Sorter
        class << self
          # Sorts an array of class names according to Tailwind CSS order rules
          # @param classes [Array<String>] Array of class names to sort
          # @return [Array<String>] Sorted array of class names
          def sort_classes(classes)
            return classes if classes.nil? || classes.empty?

            # Parse classes into tokens for detailed sorting
            tokens = classes.map { |cls| { class: cls, token: Tokenizer.parse_class(cls) } }

            # Sort by multiple criteria
            sorted_tokens = tokens.sort { |a, b| compare_tokens(a[:token], b[:token]) }

            # Extract class names from sorted tokens
            sorted_tokens.map { |item| item[:class] }
          end

          # Compares two classes for sorting purposes
          # @param class_a [String] First class to compare
          # @param class_b [String] Second class to compare
          # @return [Integer] -1, 0, or 1 for sort comparison
          def compare_classes(class_a, class_b)
            token_a = Tokenizer.parse_class(class_a)
            token_b = Tokenizer.parse_class(class_b)
            compare_tokens(token_a, token_b)
          end

          private

          # Compares two tokens for sorting
          # @param token_a [Tokenizer::Token] First token to compare
          # @param token_b [Tokenizer::Token] Second token to compare
          # @return [Integer] -1, 0, or 1 for sort comparison
          def compare_tokens(token_a, token_b)
            # 1. Compare by variant specificity (fewer variants come first)
            variant_comparison = compare_variants(token_a.variants, token_b.variants)
            return variant_comparison unless variant_comparison.zero?

            # 2. Compare by base class weight
            weight_a = OrderTable.get_class_weight(token_a.base)
            weight_b = OrderTable.get_class_weight(token_b.base)
            weight_comparison = weight_a <=> weight_b
            return weight_comparison unless weight_comparison.zero?

            # 3. Compare by important flag (non-important comes first)
            important_comparison = (token_a.important ? 1 : 0) <=> (token_b.important ? 1 : 0)
            return important_comparison unless important_comparison.zero?

            # 4. Final fallback: alphabetical order
            token_a.base <=> token_b.base
          end

          # Compares variant arrays for sorting
          # @param variants_a [Array<String>] First variant array
          # @param variants_b [Array<String>] Second variant array
          # @return [Integer] -1, 0, or 1 for sort comparison
          def compare_variants(variants_a, variants_b)
            # Less specific (fewer variants) comes first
            length_comparison = variants_a.length <=> variants_b.length
            return length_comparison unless length_comparison.zero?

            # If same length, compare individual variants
            variants_a.zip(variants_b).each do |var_a, var_b|
              next if var_a == var_b

              weight_a = OrderTable.get_variant_weight(var_a)
              weight_b = OrderTable.get_variant_weight(var_b)
              variant_weight_comparison = weight_a <=> weight_b
              return variant_weight_comparison unless variant_weight_comparison.zero?

              # Fallback to alphabetical
              return var_a <=> var_b
            end

            0 # All variants are identical
          end

          # Gets the sort weight for a given class (delegated to OrderTable)
          # @param class_name [String] The class name to get weight for
          # @return [Integer] Numeric weight for sorting
          def get_class_weight(class_name)
            OrderTable.get_class_weight(class_name)
          end
        end
      end
    end
  end
end
