# frozen_string_literal: true

require 'rspec'
require_relative '../services/parser'
require_relative '../services/unique_converter'

RSpec.describe UniqueConverter do
  let(:correct_file_path) { 'spec/fixtures/file/correct_file_with_unique_data.log' }
  let(:parser) { Parser.new }
  let(:correct_statistics) { { '/help_page/1' => 1, '/contact' => 1} }

  before do
    parser.file_reader(correct_file_path)
    parser.info_parser
  end
  subject { described_class.new(parser.information) }

  context 'when unique_converter is valid' do
    it 'creates unique_converter instance without errors' do
      expect { subject }.to_not raise_error
    end
  end

  context 'when unique_converter statistics are collected' do
    it 'is not empty' do
      subject.convert
      expect(subject.unique_statistics.empty?).not_to eq(true)
    end

    it 'have unique host names' do
      subject.convert
      expect(subject.unique_statistics.keys).to eq(correct_statistics.keys)
    end

    it 'is an instance of Hash' do
      expect(subject.unique_statistics).to be_an_instance_of Hash
    end

    it 'data_structure is an instance of Array' do
      expect(subject.data_structure).to be_an_instance_of Array
    end
  end
end
