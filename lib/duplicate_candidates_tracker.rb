class DuplicateCandidatesTracker

  def initialize
    @size_to_file_info = {}
  end

  def add(file_info)
    files_with_this_size = @size_to_file_info.fetch(file_info.size, [])
    files_with_this_size.push(file_info)
    @size_to_file_info[file_info.size] = files_with_this_size
  end

  def candidates
    @size_to_file_info.reject do |_, value|
      value.size == 1
    end
  end
end
