require 'optparse'

class ArgumentsParser

  def initialize(args)
    @error = nil
    @options = {
        directory: '.',
        valid: true
    }
    parse(args)
  end

  def error
    @error
  end

  def options
    @options
  end

  private

  def parse(args)
    OptionParser.new do |parser|
      parser.banner = "Usage: #{File.basename $PROGRAM_NAME} [options]"
      parser.on('-h', '--help', 'Show this help message') do
        @error = parser.to_s
      end
      parser.on('-dDIRECTORY', '--directory=DIRECTORY', String, 'Directory to scan')
      parser.parse!(args, into: @options)
    end
  rescue OptionParser::ParseError => e
    @error = e.to_s
  end

end