require_relative 'arguments_parser.rb'
require_relative 'file_iterator.rb'

class DuplicateFinder

  def initialize(arguments_parser, file_iterator, duplicate_candidates_tracker)
    @arguments_parser = arguments_parser
    @file_iterator = file_iterator
    @duplicate_candidates_tracker = duplicate_candidates_tracker
  end

  def run
    unless @arguments_parser.error.nil?
      puts @arguments_parser.error
      exit 1
    end

    directory = @arguments_parser.options[:directory]
    @file_iterator.foreach_file(directory) do |file|
      @duplicate_candidates_tracker.add(file)
    end
  end
end
