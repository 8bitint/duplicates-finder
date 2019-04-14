require 'digest_duplication_resolver_strategy.rb'
require 'file_group.rb'

RSpec.describe DigestDuplicationResolverStrategy do

  before(:each) do
    @file1 = instance_double('FileInfo', path: 'file1.txt', size: 123) # digest = BBBB
    @file2 = instance_double('FileInfo', path: 'file2.txt', size: 456) # digest = CCCC
    @file3 = instance_double('FileInfo', path: 'file3.txt', size: 789) # digest = DDDD
    @file4 = instance_double('FileInfo', path: 'file4.txt', size: 123) # digest = AAAA
    @file5 = instance_double('FileInfo', path: 'file5.txt', size: 123) # digest = AAAA
    @file6 = instance_double('FileInfo', path: 'file6.txt', size: 123) # digest = BBBB

    @digest_duplication_resolver_strategy = DigestDuplicationResolverStrategy.new
  end

  it 'removes false positives based on digest' do
    expect(Digest::MD5).to receive(:file).with('file1.txt').and_return('BBBB')
    expect(Digest::MD5).to receive(:file).with('file4.txt').and_return('AAAA')
    expect(Digest::MD5).to receive(:file).with('file5.txt').and_return('AAAA')

    candidate_file_group = FileGroup.of([@file1, @file4, @file5])
    expected_file_group = FileGroup.of([@file4, @file5])
    expect(@digest_duplication_resolver_strategy.resolve(candidate_file_group)).to eq([expected_file_group])
  end

  it 'separates files of same size based on digest' do
    expect(Digest::MD5).to receive(:file).with('file1.txt').and_return('BBBB')
    expect(Digest::MD5).to receive(:file).with('file4.txt').and_return('AAAA')
    expect(Digest::MD5).to receive(:file).with('file5.txt').and_return('AAAA')
    expect(Digest::MD5).to receive(:file).with('file6.txt').and_return('BBBB')

    candidate_file_group = FileGroup.of([@file1, @file4, @file5, @file6])
    expected_file_group1 = FileGroup.of([@file1, @file6])
    expected_file_group2 = FileGroup.of([@file4, @file5])
    expect(@digest_duplication_resolver_strategy.resolve(candidate_file_group)).to eq([expected_file_group1, expected_file_group2])
  end

  it 'filters candidate groups when files have different digest' do
    expect(Digest::MD5).to receive(:file).with('file2.txt').and_return('CCCC')
    expect(Digest::MD5).to receive(:file).with('file3.txt').and_return('DDDD')

    file_group = FileGroup.of([@file2, @file3])
    expect(@digest_duplication_resolver_strategy.resolve(file_group)).to eq([])
  end
end