module Duplicates

  # File details, without requiring a file to be opened
  class File
    attr_reader :path, :size

    def initialize(path, size)
      @path = path
      @size = size
    end

    def <=>(other)
      @path <=> other.path
    end
  end

end