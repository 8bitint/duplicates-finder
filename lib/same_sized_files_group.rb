require 'digest'
require_relative 'duplicate_files_group'
require_relative 'same_sized_files_group'

module Duplicates

  class SameSizedFilesGroup
    attr_accessor :files

    def initialize(files = [])
      @files = files
    end

    def add(file)
      @files.push(file)
    end

    def size
      @files.size
    end

    # returns an array of DuplicateFilesGroup
    def duplicates
      return [] if size < 2

      group_by_content.select {|values| values.size > 1}
    end

    def ==(other)
      @files == other.files
    end

    private

    def group_by_content
      new_groups = [ DuplicateFilesGroup.new([@files.first]) ]

      @files.drop(1).each do |file|
        matching_group = new_groups.detect {|group| group.same?(file)}
        matching_group ? matching_group.add(file) : new_groups.push(DuplicateFilesGroup.new([file]))
      end
      new_groups
    end
  end

end
