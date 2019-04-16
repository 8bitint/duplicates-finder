require 'digest'
require_relative 'arguments_parser'
require_relative 'file_iterator'

class DuplicatesFinder

  def initialize(file_iterator, duplicate_file_candidates)
    @file_iterator = file_iterator
    @duplicate_file_candidates = duplicate_file_candidates
  end

  # @return array of DuplicateFilesGroups
  def duplicates
    @file_iterator.each do |fileinfo|
      @duplicate_file_candidates.add(fileinfo)
    end

    @duplicate_file_candidates.candidates.flat_map(&:duplicates)
  end
end
