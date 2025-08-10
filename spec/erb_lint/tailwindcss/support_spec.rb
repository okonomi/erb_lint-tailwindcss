# frozen_string_literal: true

require "erb_lint/tailwindcss/support/tokenizer"
require "erb_lint/tailwindcss/support/sorter"
require "erb_lint/tailwindcss/support/order_table"
require "erb_lint/tailwindcss/support/dictionary"

RSpec.describe "ERBLint::Tailwindcss::Support" do
  describe ERBLint::Tailwindcss::Support::Tokenizer do
    it "can be instantiated" do
      expect(described_class).to respond_to(:tokenize)
    end

    it "returns an empty array for empty input" do
      expect(described_class.tokenize("")).to eq([])
      expect(described_class.tokenize("   ")).to eq([])
      expect(described_class.tokenize(nil)).to eq([])
    end

    it "tokenizes simple classes" do
      tokens = described_class.tokenize("p-4 bg-red-500")
      expect(tokens.length).to eq(2)

      expect(tokens[0].base).to eq("p-4")
      expect(tokens[0].variants).to eq([])
      expect(tokens[0].important).to be false

      expect(tokens[1].base).to eq("bg-red-500")
      expect(tokens[1].variants).to eq([])
      expect(tokens[1].important).to be false
    end

    it "tokenizes classes with variants" do
      tokens = described_class.tokenize("hover:bg-blue-500 lg:text-xl")
      expect(tokens.length).to eq(2)

      expect(tokens[0].base).to eq("bg-blue-500")
      expect(tokens[0].variants).to eq(["hover"])

      expect(tokens[1].base).to eq("text-xl")
      expect(tokens[1].variants).to eq(["lg"])
    end

    it "tokenizes important classes" do
      tokens = described_class.tokenize("!p-4 !important")
      expect(tokens.length).to eq(2)

      expect(tokens[0].base).to eq("p-4")
      expect(tokens[0].important).to be true

      expect(tokens[1].base).to eq("important")
      expect(tokens[1].important).to be true
    end

    it "tokenizes complex classes with multiple variants" do
      tokens = described_class.tokenize("dark:lg:hover:bg-gray-800")
      expect(tokens.length).to eq(1)

      expect(tokens[0].base).to eq("bg-gray-800")
      expect(tokens[0].variants).to eq(%w[dark lg hover])
    end

    it "tokenizes arbitrary values" do
      tokens = described_class.tokenize("w-[100px] text-[#ff0000]")
      expect(tokens.length).to eq(2)

      expect(tokens[0].base).to eq("w-[100px]")
      expect(tokens[0].arbitrary).to eq("100px")

      expect(tokens[1].base).to eq("text-[#ff0000]")
      expect(tokens[1].arbitrary).to eq("#ff0000")
    end
  end

  describe ERBLint::Tailwindcss::Support::Sorter do
    it "can be instantiated" do
      expect(described_class).to respond_to(:sort_classes)
    end

    it "sorts classes according to Tailwind order" do
      classes = %w[bg-red-500 p-4 flex]
      sorted = described_class.sort_classes(classes)

      # flex (layout) should come before p-4 (spacing) and bg-red-500 (backgrounds)
      expect(sorted.index("flex")).to be < sorted.index("p-4")
      expect(sorted.index("p-4")).to be < sorted.index("bg-red-500")
    end

    it "sorts variants correctly" do
      classes = %w[hover:bg-red-500 bg-red-500 lg:bg-red-500]
      sorted = described_class.sort_classes(classes)

      # Non-variant should come first
      expect(sorted[0]).to eq("bg-red-500")
    end

    it "handles empty and nil inputs" do
      expect(described_class.sort_classes([])).to eq([])
      expect(described_class.sort_classes(nil)).to eq(nil)
    end

    it "compares individual classes" do
      # flex comes before bg (layout vs backgrounds)
      expect(described_class.compare_classes("flex", "bg-red-500")).to be < 0
      expect(described_class.compare_classes("bg-red-500", "flex")).to be > 0

      # Same class should be equal
      expect(described_class.compare_classes("p-4", "p-4")).to eq(0)
    end
  end

  describe ERBLint::Tailwindcss::Support::OrderTable do
    it "has order constants defined" do
      expect(described_class::TAILWIND_CLASS_ORDER).to be_a(Hash)
      expect(described_class::VARIANT_ORDER).to be_a(Hash)
    end

    it "can get class weight" do
      expect(described_class.get_class_weight("bg-red-500")).to be_a(Integer)
    end

    it "can get variant weight" do
      expect(described_class.get_variant_weight("hover")).to be_a(Integer)
    end
  end

  describe ERBLint::Tailwindcss::Support::Dictionary do
    it "has known class and variant constants" do
      expect(described_class::KNOWN_CLASSES).to be_a(Set)
      expect(described_class::KNOWN_VARIANTS).to be_a(Set)
    end

    it "can check known variants" do
      expect(described_class.known_variant?("hover")).to be true
      expect(described_class.known_variant?("unknown")).to be false
    end

    it "can detect arbitrary values" do
      expect(described_class.arbitrary_value?("w-[100px]")).to be true
      expect(described_class.arbitrary_value?("w-10")).to be false
    end

    it "can check known classes" do
      expect(described_class).to respond_to(:known_class?)
    end
  end
end
