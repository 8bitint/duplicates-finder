require 'digest'

# File details, without requiring a file to be opened
class FileInfo
  attr_reader :filename, :size

  def initialize(filename, size)
    @filename = filename
    @size = size
    @digest = nil
  end

  def digest
    if @digest.nil?
      @digest = Digest::MD5.file(@filename)
    end
    @digest
  end

  def to_s
    "#{filename} (#{size} bytes)"
  end
end