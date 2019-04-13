require 'duplicates_by_digest_resolver.rb'

RSpec.describe DuplicatesByDigestResolver do

  before(:each) do
    @file1 = instance_double('FileInfo', path: 'file1.txt', size: 123, digest: 'BBBB')
    @file2 = instance_double('FileInfo', path: 'file2.txt', size: 456, digest: 'CCCC')
    @file3 = instance_double('FileInfo', path: 'file3.txt', size: 789, digest: 'DDDD')
    @file4 = instance_double('FileInfo', path: 'file5.txt', size: 123, digest: 'AAAA')
    @file5 = instance_double('FileInfo', path: 'file6.txt', size: 123, digest: 'AAAA')
    @file6 = instance_double('FileInfo', path: 'file7.txt', size: 123, digest: 'BBBB')

    @duplicates_by_digest_resolver = DuplicatesByDigestResolver.new
  end

  it 'removes false positives based on file size' do
    expect(@duplicates_by_digest_resolver.resolve([@file1, @file4, @file5]))
      .to eq([[@file4, @file5]])
  end

  it 'separates files of same size based on content' do
    expect(@duplicates_by_digest_resolver.resolve([@file1, @file4, @file5, @file6]))
      .to eq([[@file1, @file6], [@file4, @file5]])
  end

  it 'filters candidate groups when files have different content' do
    expect(@duplicates_by_digest_resolver.resolve([@file2, @file3]))
        .to eq([])
  end
end