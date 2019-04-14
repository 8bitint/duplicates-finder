class FileGroup
  attr_accessor :files

  def initialize
    @files = []
  end

  def add(fileinfo)
    @files.push(fileinfo)
  end

  def size
    @files.size
  end

  def ==(other)
    @files == other.files
  end

  def self.of(fileinfos)
    file_group = FileGroup.new
    fileinfos.each {|f| file_group.add(f)}
    file_group
  end
end