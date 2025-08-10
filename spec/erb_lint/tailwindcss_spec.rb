# frozen_string_literal: true

RSpec.describe ERBLint::Tailwindcss do
  it "has a version number" do
    expect(ERBLint::Tailwindcss::VERSION).not_to be nil
  end

  it "can be required without errors" do
    expect { require "erb_lint/tailwindcss" }.not_to raise_error
  end

  it "defines the correct module hierarchy" do
    expect(ERBLint::Tailwindcss).to be_a(Module)
    expect(ERBLint::Tailwindcss::Error).to be < StandardError
  end
end
