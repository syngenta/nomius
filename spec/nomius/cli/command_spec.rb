# frozen_string_literal: true

require_relative "../../../lib/nomius/cli/command"

RSpec.describe Nomius::CLI::Command do
  let(:command) { described_class.new.parse(args) }

  describe "fast exit" do
    context "when no arguments" do
      let(:args) { [] }

      it "prints help and exit" do
        expect do
          expect { command.run }.to output(/Usage: nomius/).to_stdout
        end.to raise_error(SystemExit)
      end
    end

    context "when no --input or names" do
      let(:args) { %w[--silent --output test.csv] }

      it "prints help and exit" do
        expect do
          expect { command.run }.to output(/Usage: nomius/).to_stdout
        end.to raise_error(SystemExit)
      end
    end

    context "when --help argument" do
      let(:args) { %w[--help] }

      it "prints help and exit" do
        expect do
          expect { command.run }.to output(/Usage: nomius/).to_stdout
        end.to raise_error(SystemExit)
      end
    end

    context "when --version argument" do
      let(:args) { %w[--version] }

      it "prints version and exit" do
        expect do
          expect { command.run }.to output(Nomius::VERSION).to_stdout
        end.to raise_error(SystemExit)
      end
    end
  end

  describe "when parsing params" do
    subject(:params) do
      command.run
      command.params
    end

    context "when silent" do
      let(:args) { %w[--silent testname1] }

      it { expect(params[:silent]).to be(true) }
    end

    context "when not silent" do
      let(:args) { %w[testname1] }

      it { expect(params[:silent]).to be(false) }
    end

    context "when one name" do
      let(:args) { %w[testname1] }

      it { expect(params[:names]).to eq(%w[testname1]) }
      it { expect(params[:input]).to be_nil }
    end

    context "when several names" do
      let(:args) { %w[testname1 testname2] }

      it { expect(params[:names]).to eq(%w[testname1 testname2]) }
      it { expect(params[:input]).to be_nil }
    end

    context "when --input file" do
      let(:args) { %w[--input file.txt] }

      it { expect(params[:input]).to eq("file.txt") }
      it { expect(params[:names]).to eq([]) }
    end

    context "when --output file" do
      let(:args) { %w[--output file.txt testname1] }

      it { expect(params[:output]).to eq("file.txt") }
    end
  end
end
