class FileGroup
  attr_accessor :files

  def initialize
    @files = []
  end

  def add(file_info)
    @files.push(file_info)
  end

  def size
    @files.size
  end

  def ==(other)
    @files == other.files
  end

  def self.of(file_info_arr)
    file_group = FileGroup.new
    file_info_arr.each { |f| file_group.add(f) }
    file_group
  end
end