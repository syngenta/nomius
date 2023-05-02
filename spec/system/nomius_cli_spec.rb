# frozen_string_literal: true

require "English"
require "tempfile"

RSpec.describe "nomius command" do
  context "without arguments" do
    let(:command) { "bundle exec nomius" }
    let(:expected_console_output) { File.read("spec/sample_data/expected_help_output.txt") }

    it "exit nomius with 1 and show help" do
      results = `#{command}`.gsub(/ +$/, "")

      expect($CHILD_STATUS.exitstatus).to eq(1)
      expect(results).to eq(expected_console_output)
    end
  end

  context "with --help flag" do
    let(:command) { "bundle exec nomius --help" }
    let(:expected_console_output) { File.read("spec/sample_data/expected_help_output.txt") }

    it "exit nomius with 0 and show help" do
      results = `#{command}`.gsub(/ +$/, "")

      expect($CHILD_STATUS.exitstatus).to eq(0)
      expect(results).to eq(expected_console_output)
    end
  end

  context "with input and output to CSV" do
    let(:input_path) { "spec/sample_data/system/input.csv" }
    let(:output) { Tempfile.new("output.csv") }
    let(:command) do
      "bundle exec nomius --input #{input_path} --output #{output.path}"
    end
    let(:expected_csv_output) { File.read("spec/sample_data/system/output.csv") }
    let(:expected_console_output) { File.read("spec/sample_data/system/console_output.txt") }

    # NOTE: Nomius intentionally makes requests to external services during this spec.
    # It's the one integration spec for complete end-to-end testing. Keeping it as is for now.
    # Later, we could use some proxy to stub HTTP & WHOIS requests.
    it "runs nomius and print output" do
      # Force tty-table to use full-width table.
      allow(TTY::Screen).to receive(:width).and_return(1000)

      results = `#{command}`

      expect($CHILD_STATUS.exitstatus).to eq(0)
      expect(results).to eq(expected_console_output)
      expect(output.read).to eq(expected_csv_output)
    end
  end
end
