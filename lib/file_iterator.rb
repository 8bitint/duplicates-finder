require_relative 'file_info'

class FileIterator

  def foreach_file(base_directory)
    # Don't let glob evaluate base_directory in case of shenanigans
    Dir.chdir(base_directory)
    Dir.glob('**/*').each do |path|
      if FileTest.file?(path)
        yield FileInfo.new(path, FileTest.size(path))
      end
    end
  end
end
