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

    duplicates_groups = []
    @duplicate_file_candidates.candidates.each do |same_sized_group|
      duplicates_groups.push(same_sized_group.duplicates)
    end
    duplicates_groups.flatten
  end
end
