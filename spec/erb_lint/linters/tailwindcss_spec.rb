# frozen_string_literal: true

require "erb_lint/tailwindcss"

RSpec.describe "ERBLint::Linters::Tailwindcss" do
  describe "linter classes" do
    it "ClassOrder can be instantiated" do
      linter = ERBLint::Linters::Tailwindcss::ClassOrder.new(nil, {})
      expect(linter).to be_a(ERBLint::Linters::Tailwindcss::ClassOrder)
    end

    it "Duplicate can be instantiated" do
      linter = ERBLint::Linters::Tailwindcss::Duplicate.new(nil, {})
      expect(linter).to be_a(ERBLint::Linters::Tailwindcss::Duplicate)
    end

    it "Unknown can be instantiated" do
      linter = ERBLint::Linters::Tailwindcss::Unknown.new(nil, {})
      expect(linter).to be_a(ERBLint::Linters::Tailwindcss::Unknown)
    end
  end

  describe "linter configuration" do
    it "ClassOrder has proper config schema" do
      schema = ERBLint::Linters::Tailwindcss::ClassOrder::CONFIG_SCHEMA
      expect(schema).to be_a(Hash)
      expect(schema[:properties]).to have_key(:order_preset)
      expect(schema[:properties]).to have_key(:grouping)
    end

    it "Duplicate has proper config schema" do
      schema = ERBLint::Linters::Tailwindcss::Duplicate::CONFIG_SCHEMA
      expect(schema).to be_a(Hash)
      expect(schema[:properties]).to have_key(:dedupe_across_variants)
    end

    it "Unknown has proper config schema" do
      schema = ERBLint::Linters::Tailwindcss::Unknown::CONFIG_SCHEMA
      expect(schema).to be_a(Hash)
      expect(schema[:properties]).to have_key(:allow_arbitrary_values)
      expect(schema[:properties]).to have_key(:safelist)
      expect(schema[:properties]).to have_key(:plugins)
    end
  end

  describe "linter methods" do
    let(:class_order) { ERBLint::Linters::Tailwindcss::ClassOrder.new(nil, {}) }
    let(:duplicate) { ERBLint::Linters::Tailwindcss::Duplicate.new(nil, {}) }
    let(:unknown) { ERBLint::Linters::Tailwindcss::Unknown.new(nil, {}) }

    it "linters respond to run method" do
      expect(class_order).to respond_to(:run)
      expect(duplicate).to respond_to(:run)
      expect(unknown).to respond_to(:run)
    end

    it "linters with autocorrect respond to autocorrect method" do
      expect(class_order).to respond_to(:autocorrect)
      expect(duplicate).to respond_to(:autocorrect)
    end
  end
end
