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
          def tokenize(_class_string)
            # Implementation will be added when order extraction system is ready
            []
          end

          private

          # Parses a single class into a Token
          # @param class_name [String] Individual class name
          # @return [Token] Parsed token structure
          def parse_class(class_name)
            # Implementation placeholder
            Token.new(variants: [], base: class_name, important: false)
          end
        end
      end
    end
  end
end
