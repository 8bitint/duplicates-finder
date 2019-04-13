require_relative 'arguments_parser.rb'
require_relative 'file_iterator.rb'
require 'digest'

class DuplicateFinder

  def initialize(arguments_parser, file_iterator, candidates_by_filesize_resolver, duplicates_by_content_resolver)
    @arguments_parser = arguments_parser
    @file_iterator = file_iterator
    @candidates_by_filesize_resolver = candidates_by_filesize_resolver
    @duplicates_by_content_resolver = duplicates_by_content_resolver
  end

  def run
    unless @arguments_parser.error.nil?
      puts @arguments_parser.error
      exit 1
    end

    directory = @arguments_parser.options[:directory]
    @file_iterator.foreach_file(directory) do |path|
      @candidates_by_filesize_resolver.add(path)
    end

    @candidates_by_filesize_resolver.candidate_groups.each do |group|
      @duplicates_by_content_resolver.resolve(group).each do |_duplicates|
        # ignore
      end
    end
  end
end
