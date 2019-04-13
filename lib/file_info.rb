require 'digest'

# File details, without requiring a file to be opened
class FileInfo
  attr_reader :path, :size

  def initialize(path, size)
    @path = path
    @size = size
    @digest = nil
  end

  def digest
    if @digest.nil?
      @digest = Digest::MD5.file(@path)
    end
    @digest
  end

  def to_s
    "#{path} (#{size} bytes)"
  end
end