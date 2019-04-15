require 'duplicates_finder.rb'
require 'file_group.rb'

RSpec.describe DuplicatesFinder do

  before(:each) do
    @file_iterator = instance_double('FileIterator')
    @duplicate_file_candidates = instance_double('DuplicateFileCandidates')
    @duplicates_resolver = instance_double('DuplicatesResolver')
    @duplicate_finder = DuplicatesFinder.new(@file_iterator, @duplicate_file_candidates, @duplicates_resolver)

    allow(@file_iterator).to receive(:foreach_file)
  end

  it 'orchestrates identification of candidates and duplicates' do
    file_to_track = 'not a real file'

    file1 = instance_double('FileInfo')
    file2 = instance_double('FileInfo')
    file3 = instance_double('FileInfo')
    file4 = instance_double('FileInfo')
    not_duplicates_group = FileGroup.of([file1, file2])
    duplicates_group = FileGroup.of([file3, file4])

    expect(@file_iterator).to receive(:foreach_file).and_yield(file_to_track)
    expect(@duplicate_file_candidates).to receive(:add).with(file_to_track)
    expect(@duplicate_file_candidates).to receive(:candidates).and_return([not_duplicates_group, duplicates_group])
    expect(@duplicates_resolver).to receive(:resolve).with(not_duplicates_group).and_return([])
    expect(@duplicates_resolver).to receive(:resolve).with(duplicates_group).and_return([duplicates_group])
    expect(@duplicate_finder.find).to eq([duplicates_group])
  end

end
