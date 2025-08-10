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
