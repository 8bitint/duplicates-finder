require 'file_iterator.rb'

RSpec.describe FileIterator do

  before(:each) do
    @file_path_1 = './one/one'
    @file_path_2 = './one/two'
    @file_path_3 = './two/one'
    @dir_path = 'not-a-file'

    @paths = [@file_path_1, @file_path_2, @file_path_3, @dir_path]
  end

  it "yields for each file that isn't a directory" do
    expect(Find).to receive(:find).and_return(@paths)
    expect(FileTest).to receive(:file?).with(@file_path_1).and_return(true)
    expect(FileTest).to receive(:file?).with(@file_path_2).and_return(true)
    expect(FileTest).to receive(:file?).with(@file_path_3).and_return(true)
    expect(FileTest).to receive(:file?).with(@dir_path).and_return(false)
    expect(File).to receive(:new).with(@file_path_1).and_return(double('File'))
    expect(File).to receive(:new).with(@file_path_2).and_return(double('File'))
    expect(File).to receive(:new).with(@file_path_3).and_return(double('File'))

    FileIterator.new.foreach_file("directory") do |_blah|
    end
  end
end