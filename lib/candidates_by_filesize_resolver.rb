class CandidatesByFilesizeResolver

  def initialize
    @candidate_grouping_by_filesize = {}
  end

  def add(file_info)
    files_with_this_size = @candidate_grouping_by_filesize.fetch(file_info.size, [])
    files_with_this_size.push(file_info)
    @candidate_grouping_by_filesize[file_info.size] = files_with_this_size
  end

  def candidate_groups
    groups = []
    selected_candidates = @candidate_grouping_by_filesize.reject do |_, values|
      values.size == 1
    end

    selected_candidates.each_value do |value|
      groups.push(value)
    end
    groups
  end
end
