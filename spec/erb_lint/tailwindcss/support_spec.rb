# frozen_string_literal: true

require "erb_lint/tailwindcss/support/tokenizer"
require "erb_lint/tailwindcss/support/sorter"
require "erb_lint/tailwindcss/support/order_table"

RSpec.describe "ERBLint::Tailwindcss::Support" do
  describe ERBLint::Tailwindcss::Support::Tokenizer do
    it "can be instantiated" do
      expect(described_class).to respond_to(:tokenize)
    end

    it "returns an empty array for empty input" do
      expect(described_class.tokenize("")).to eq([])
    end
  end

  describe ERBLint::Tailwindcss::Support::Sorter do
    it "can be instantiated" do
      expect(described_class).to respond_to(:sort_classes)
    end

    it "returns input classes unchanged (placeholder)" do
      classes = %w[bg-red-500 p-4 text-white]
      expect(described_class.sort_classes(classes)).to eq(classes)
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
end
