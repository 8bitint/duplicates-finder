# File details, without requiring a file to be opened
class FileInfo
  attr_reader :path, :size

  def initialize(path, size)
    @path = path
    @size = size
  end

end