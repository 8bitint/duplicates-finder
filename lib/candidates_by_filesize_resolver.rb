class CandidatesByFilesizeResolver

  def initialize
    @size_to_file_info = {}
  end

  def add(file_info)
    files_with_this_size = @size_to_file_info.fetch(file_info.size, [])
    files_with_this_size.push(file_info)
    @size_to_file_info[file_info.size] = files_with_this_size
  end

  def candidate_groups
    groups = []
    selected_candidates = @size_to_file_info.reject do |_, values|
      values.size == 1
    end

    selected_candidates.each_value do |value|
      groups.push(value)
    end
    groups
  end
end
