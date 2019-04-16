module Duplicates

  class DuplicateFilesGroup
    attr_reader :files

    def initialize(files = [])
      @files = files
    end

    def add(file)
      @files.push(file)
    end

    def size
      @files.size
    end

    def duplicates
      @files
    end

    def print
      puts 'Duplicates:'

      @files.each do |file|
        puts "\t#{file.path}"
      end
    end

    def ==(other)
      @files.size == other.files.size &&
          @files.sort == other.files.sort
    end
  end

end