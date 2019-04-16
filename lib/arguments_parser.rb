require 'optparse'

class ArgumentsParser
  attr_reader :options, :user_hint

  def initialize(args)
    @user_hint = nil
    @options = {directory: '.'}
    parse(args)
  end

  def has_error?
    !@user_hint.nil?
  end

  private

  def parse(args)
    OptionParser.new do |parser|
      parser.banner = "Usage: #{File.basename $PROGRAM_NAME} [options]"
      parser.on('-h', '--help', 'Show this help message') do
        @user_hint = parser.to_s
      end
      parser.on('-dDIRECTORY', '--directory=DIRECTORY', String, 'Directory to scan') do |value|
        @options[:directory] = value
      end
      parser.parse!(args)
    end
  rescue OptionParser::ParseError => e
    @user_hint = e.to_s
  end

end