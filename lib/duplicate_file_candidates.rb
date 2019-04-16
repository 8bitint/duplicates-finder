require_relative 'same_sized_files_group'

module Duplicates

  class DuplicateFileCandidates
    def initialize
      @same_sized_file_groups = Hash.new {|hash, key| hash[key] = SameSizedFilesGroup.new}
    end

    def add(file)
      @same_sized_file_groups[file.size].add(file)
    end

    # @return array of same same sized files groups
    def candidates
      @same_sized_file_groups.values.select {|group| group.size > 1}
    end
  end

end