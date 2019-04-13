require_relative 'arguments_parser.rb'
require_relative 'file_iterator.rb'
require 'digest'

class DuplicatesFinder

  def initialize(options, file_iterator, candidates_by_filesize_resolver, duplicates_by_digest_resolver)
    @options = options
    @file_iterator = file_iterator
    @candidates_by_filesize_resolver = candidates_by_filesize_resolver
    @duplicates_by_digest_resolver = duplicates_by_digest_resolver
  end

  def find
    @file_iterator.foreach_file(@options[:directory]) do |path|
      @candidates_by_filesize_resolver.add(path)
    end

    duplicates_groups = []
    @candidates_by_filesize_resolver.candidate_groups.each do |group|
      duplicates = @duplicates_by_digest_resolver.resolve(group)
      duplicates_groups.push(duplicates.flatten) unless duplicates.empty?
    end
    duplicates_groups
  end
end
