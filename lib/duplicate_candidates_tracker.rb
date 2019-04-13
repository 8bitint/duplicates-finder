class DuplicateCandidatesTracker

  def initialize
    @size_to_files = {}
  end

  def add(file)
    file_size = file.size

    files_with_this_size = @size_to_files.fetch(file_size, [])
    files_with_this_size.push(file)
    @size_to_files[file_size] = files_with_this_size
  end

  def candidates
    @size_to_files.reject do |_key, value|
      value.size == 1
    end
  end
end
