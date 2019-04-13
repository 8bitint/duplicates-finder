require 'arguments_parser.rb'

RSpec.describe ArgumentsParser do

  it 'defaults to the current directory when directory not specified' do
    options = ArgumentsParser.new([]).options
    expect(options[:directory]).to eq('.')
  end

  describe 'when users specify the directory to scan' do
    it 'parses the short form' do
      options = ArgumentsParser.new(['-dSOME_DIR']).options
      expect(options[:directory]).to eq('SOME_DIR')
    end

    it 'parses the long form' do
      options = ArgumentsParser.new(['--directory=SOME_DIR']).options
      expect(options[:directory]).to eq('SOME_DIR')
    end
  end

  describe 'when parsing errors are encountered' do
    it 'states when an argument is missing' do
      arguments_parser = ArgumentsParser.new(['--directory'])
      expect(arguments_parser.error).to eq('missing argument: --directory')
    end

    it 'states when an argument is not recognised' do
      arguments_parser = ArgumentsParser.new(['-X'])
      expect(arguments_parser.error).to eq('invalid option: -X')
    end
  end

  describe 'when a user requests help' do
    it 'is given as helpful form of error' do
      arguments_parser = ArgumentsParser.new(['-h'])
      expect(arguments_parser.error).to include('Usage:')
    end
  end
end
