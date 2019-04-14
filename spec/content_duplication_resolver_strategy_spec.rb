require 'content_duplication_resolver_strategy.rb'
require 'file_group.rb'

RSpec.describe ContentDuplicationResolverStrategy do

  before(:each) do
    @file1 = instance_double('File', path: 'path1.txt')
    @file2 = instance_double('File', path: 'path2.txt')
    @candidate_group = FileGroup.of([@file1, @file2])

    @content_duplication_resolver_strategy = ContentDuplicationResolverStrategy.new
  end

  it 'fails when resolving anything but 2 candidate duplications' do
    expect(FileUtils).to_not receive(:compare_file)
    expect { @content_duplication_resolver_strategy.resolve(FileGroup.of([])) }.to raise_error(RuntimeError)
  end

  it 'returns an empty array if the files are not identical' do
    expect(FileUtils).to receive(:compare_file).with('path1.txt', 'path2.txt').and_return(false)
    expect(@content_duplication_resolver_strategy.resolve(@candidate_group)).to eq([])
  end

  it 'returns an array with the original file group if they are identical' do
    expect(FileUtils).to receive(:compare_file).with('path1.txt', 'path2.txt').and_return(true)
    expect(@content_duplication_resolver_strategy.resolve(@candidate_group)).to eq([@candidate_group])
  end
end