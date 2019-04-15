require_relative 'same_sized_files_group'

class DuplicateFileCandidates

  def initialize
    @same_sized_file_groups = {}
  end

  def add(fileinfo)
    same_sized_files = @same_sized_file_groups.fetch(fileinfo.size, SameSizedFilesGroup.new)
    same_sized_files.add(fileinfo)
    @same_sized_file_groups[fileinfo.size] = same_sized_files
  end

  # @return array of same same sized files groups
  def candidates
    @same_sized_file_groups.select { |_key, group| group.size > 1 }.values
  end
end