require_relative 'file'

module Duplicates

  class FileIterator

    def initialize(directory)
      @directory = directory
    end

    def each
      Dir.chdir(@directory) # Don't let glob evaluate base_directory in case of shenanigans
      Dir.glob('**/*')
          .select {|path| FileTest.file?(path)}
          .each {|file_path| yield Duplicates::File.new(file_path, FileTest.size(file_path))}
    end
  end

end