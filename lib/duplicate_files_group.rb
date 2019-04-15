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

    @files.each do |fileinfo|
      puts "\t#{fileinfo.path}"
    end
  end

  def ==(other)
    @files == other.files
  end

end