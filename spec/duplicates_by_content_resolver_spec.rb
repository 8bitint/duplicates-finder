require 'duplicates_by_content_resolver.rb'

RSpec.describe DuplicatesByContentResolver do

  before(:each) do
    @file1 = double('FileInfo', filename: 'file1.txt', size: 123, digest: 'BBBB')
    @file2 = double('FileInfo', filename: 'file2.txt', size: 456, digest: 'CCCC')
    @file3 = double('FileInfo', filename: 'file3.txt', size: 789, digest: 'DDDD')
    @file4 = double('FileInfo', filename: 'file5.txt', size: 123, digest: 'AAAA')
    @file5 = double('FileInfo', filename: 'file6.txt', size: 123, digest: 'AAAA')
    @file6 = double('FileInfo', filename: 'file7.txt', size: 123, digest: 'BBBB')

    @duplicates_by_content_resolver = DuplicatesByContentResolver.new
  end

  it 'removes false positives based on file size' do
    expect(@duplicates_by_content_resolver.resolve([@file1, @file4, @file5]))
      .to eq([[@file4, @file5]])
  end

  it 'separates files of same size based on content' do
    expect(@duplicates_by_content_resolver.resolve([@file1, @file4, @file5, @file6]))
      .to eq([[@file1, @file6], [@file4, @file5]])
  end

  it 'filters candidate groups when files have different content' do
    expect(@duplicates_by_content_resolver.resolve([@file2, @file3]))
        .to eq([])
  end
end