# File details, without requiring a file to be opened
class FileInfo
  attr_reader :filename, :size

  def initialize(filename, size)
    @filename = filename
    @size = size
  end

  def to_s
    "#{filename} (#{size} bytes)"
  end
end