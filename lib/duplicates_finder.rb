require 'digest'
require_relative 'arguments_parser'
require_relative 'file_iterator'

module Duplicates

  class DuplicatesFinder

    def initialize(file_iterator, duplicate_file_candidates)
      @file_iterator = file_iterator
      @duplicate_file_candidates = duplicate_file_candidates
    end

    # @return array of DuplicateFilesGroups
    def duplicates
      @file_iterator.each do |file|
        @duplicate_file_candidates.add(file)
      end

      @duplicate_file_candidates.candidates.flat_map(&:duplicates)
    end
  end

end