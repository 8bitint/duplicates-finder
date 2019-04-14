require_relative 'file_group.rb'

class DuplicateFileCandidates

  def initialize
    @duplicate_candidate_groups = {}
  end

  def add(fileinfo)
    candidate_group = @duplicate_candidate_groups.fetch(fileinfo.size, FileGroup.new)
    candidate_group.add(fileinfo)
    @duplicate_candidate_groups[fileinfo.size] = candidate_group
  end

  # @return array of file groups
  def candidates
    @duplicate_candidate_groups.select { |_key, group| group.size > 1 }.values
  end
end