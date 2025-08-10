# frozen_string_literal: true

module ERBLint
  module Tailwindcss
    module Support
      # Tokenizer for parsing Tailwind CSS class strings into structured components
      # Breaks down classes into variants, base utilities, and modifiers
      class Tokenizer
        # Token structure: { variants: Array, base: String, important: Boolean, arbitrary: String? }
        Token = Struct.new(:variants, :base, :important, :arbitrary, keyword_init: true)

        class << self
          # Tokenizes a class string into an array of Token objects
          # @param class_string [String] The class attribute value to tokenize
          # @return [Array<Token>] Array of parsed tokens
          def tokenize(class_string)
            return [] if class_string.nil? || class_string.strip.empty?

            # Split by whitespace and filter out empty strings
            class_names = class_string.strip.split(/\s+/).reject(&:empty?)

            # Parse each class name into a token
            class_names.map { |class_name| parse_class(class_name) }
          end

          # Parses a single class into a Token (public for use by Sorter)
          # @param class_name [String] Individual class name
          # @return [Token] Parsed token structure
          def parse_class(class_name)
            # Check for important flag
            important = class_name.start_with?("!")
            working_name = important ? class_name[1..] : class_name

            # Extract variants (everything before the last colon)
            variants = []
            base_class = working_name

            if working_name.include?(":")
              parts = working_name.split(":")
              if parts.length > 1
                variants = parts[0..-2] # All parts except the last
                base_class = parts.last # Last part is the base class
              end
            end

            # Check for arbitrary values (contains [...])
            arbitrary = nil
            if base_class.include?("[") && base_class.include?("]")
              match = base_class.match(/\[([^\]]+)\]/)
              arbitrary = match[1] if match
            end

            Token.new(
              variants: variants,
              base: base_class,
              important: important,
              arbitrary: arbitrary
            )
          end
        end
      end
    end
  end
end
