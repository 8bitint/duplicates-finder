require_relative 'file_info'

class FileIterator

  def initialize(directory)
    @directory = directory
  end

  def foreach_file
    # Don't let glob evaluate base_directory in case of shenanigans
    Dir.chdir(@directory)
    Dir.glob('**/*').each do |path|
      if FileTest.file?(path)
        yield FileInfo.new(path, FileTest.size(path))
      end
    end
  end
end
