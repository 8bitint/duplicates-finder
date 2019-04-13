require 'find'

class FileIterator

  def foreach_file(base_directory)
    Find.find(base_directory).each do |path|
      if FileTest.file?(path)
        yield File.new(path)
      end
    end
  end
end