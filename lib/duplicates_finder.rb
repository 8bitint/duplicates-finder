require_relative 'arguments_parser.rb'
require_relative 'file_iterator.rb'
require 'digest'

class DuplicatesFinder

  def initialize(options, file_iterator, duplicate_file_candidates, duplicates_resolver)
    @options = options
    @file_iterator = file_iterator
    @duplicate_file_candidates = duplicate_file_candidates
    @duplicates_resolver = duplicates_resolver
  end

  # @return array of confirmed candidate groups
  def find
    @file_iterator.foreach_file(@options[:directory]) do |fileinfo|
      @duplicate_file_candidates.add(fileinfo)
    end

    duplicates_groups = []
    @duplicate_file_candidates.candidates.each do |group|
      duplicates_groups.push(@duplicates_resolver.resolve(group))
    end
    duplicates_groups.flatten
  end
end
