require 'arguments_parser'

module Duplicates

  RSpec.describe ArgumentsParser do

    it 'defaults to the current directory when directory not specified' do
      options = ArgumentsParser.new([]).options
      expect(options[:directory]).to eq('.')
    end

    it 'defaults to not having an error' do
      expect(ArgumentsParser.new([]).has_error?).to eq(false)
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
      it 'it has an error' do
        arguments_parser = ArgumentsParser.new(['--bad-option'])
        expect(arguments_parser.has_error?).to eq(true)
      end

      it 'hints to users that an argument is missing' do
        arguments_parser = ArgumentsParser.new(['--directory'])
        expect(arguments_parser.user_hint).to eq('missing argument: --directory')
      end

      it 'hints to users when an argument is not recognised' do
        arguments_parser = ArgumentsParser.new(['-X'])
        expect(arguments_parser.user_hint).to eq('invalid option: -X')
      end
    end

    describe 'when a user requests help' do
      it 'is given as helpful form of error' do
        arguments_parser = ArgumentsParser.new(['-h'])
        expect(arguments_parser.user_hint).to include('Usage:')
      end
    end
  end

end