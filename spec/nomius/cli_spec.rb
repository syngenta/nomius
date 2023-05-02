# frozen_string_literal: true

require_relative "../../lib/nomius/cli"

RSpec.describe Nomius::CLI do
  describe "#run" do
    it "parse arguments and call Runner" do
      allow(Nomius::CLI::Runner).to receive(:run)

      described_class.run(%w[--silent --input i.txt --output o.txt name1 name2])

      expect(Nomius::CLI::Runner).to have_received(:run).with(
        names: %w[name1 name2],
        silent: true,
        input: "i.txt",
        output: "o.txt"
      )
    end
  end
end
