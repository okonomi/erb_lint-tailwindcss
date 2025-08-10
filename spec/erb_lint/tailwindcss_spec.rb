# frozen_string_literal: true

RSpec.describe ErbLint::Tailwindcss do
  it "has a version number" do
    expect(ErbLint::Tailwindcss::VERSION).not_to be nil
  end

  it "can be required without errors" do
    expect { require "erb_lint/tailwindcss" }.not_to raise_error
  end

  it "defines the correct module hierarchy" do
    expect(ErbLint::Tailwindcss).to be_a(Module)
    expect(ErbLint::Tailwindcss::Error).to be < StandardError
  end
end
