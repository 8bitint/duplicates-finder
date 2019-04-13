require_relative 'arguments_parser.rb'

class DuplicateFinder

  def initialize(arguments_parser)
    @arguments_parser = arguments_parser
  end

  def run
    unless @arguments_parser.error.nil?
      puts @arguments_parser.error
      exit 1
    end
  end
end
