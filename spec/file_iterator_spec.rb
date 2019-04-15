require 'file_iterator.rb'

RSpec.describe FileIterator do

  before(:each) do
    @file_path1 = './one/one'
    @file_path2 = './one/two'
    @file_path3 = './two/one'
    @dir_path = 'not-a-file'

    @paths = [@file_path1, @file_path2, @file_path3, @dir_path]

    allow(Dir).to receive(:chdir)
  end

  it 'yields for each file that not a directory' do
    expect(Dir).to receive(:glob).and_return(@paths)
    expect(FileTest).to receive(:file?).with(@file_path1).and_return(true)
    expect(FileTest).to receive(:file?).with(@file_path2).and_return(true)
    expect(FileTest).to receive(:file?).with(@file_path3).and_return(true)
    expect(FileTest).to receive(:file?).with(@dir_path).and_return(false)
    expect(FileTest).to receive(:size).with(@file_path1).and_return(123)
    expect(FileTest).to receive(:size).with(@file_path2).and_return(456)
    expect(FileTest).to receive(:size).with(@file_path3).and_return(789)

    FileIterator.new('directory').foreach_file do |_blah|
    end
  end
end