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
            # Implementation will be added when order table is generated
            classes
          end

          # Compares two classes for sorting purposes
          # @param class_a [String] First class to compare
          # @param class_b [String] Second class to compare
          # @return [Integer] -1, 0, or 1 for sort comparison
          def compare_classes(_class_a, _class_b)
            # Implementation will use order table weights
            0
          end

          private

          # Gets the sort weight for a given class
          # @param class_name [String] The class name to get weight for
          # @return [Integer] Numeric weight for sorting
          def get_class_weight(_class_name)
            # Will use order table data
            0
          end
        end
      end
    end
  end
end
