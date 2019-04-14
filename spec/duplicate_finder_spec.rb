require 'duplicates_finder.rb'

RSpec.describe DuplicatesFinder do

  before(:each) do
    @options = { directory: 'DIRECTORY' }
    @file_iterator = instance_double('FileIterator')
    @duplicate_file_candidates = instance_double('DuplicateFileCandidates')
    @duplicates_by_digest_resolver = instance_double('DuplicatesByDigestResolver')
    @duplicate_finder = DuplicatesFinder.new(@options, @file_iterator, @duplicate_file_candidates, @duplicates_by_digest_resolver)

    allow(@file_iterator).to receive(:foreach_file)
  end

  it 'orchestrates identification of candidates and duplicates' do
    file_to_track = 'not a real file'

    file1 = instance_double('FileInfo', digest: 'file1-digest')
    file2 = instance_double('FileInfo', digest: 'file2-digest')
    file3 = instance_double('FileInfo', digest: 'file3-digest')
    file4 = instance_double('FileInfo', digest: 'file4-digest')

    expect(@file_iterator).to receive(:foreach_file).with('DIRECTORY').and_yield(file_to_track)
    expect(@duplicate_file_candidates).to receive(:add).with(file_to_track)
    expect(@duplicate_file_candidates).to receive(:candidates).and_return([[file1, file2], [file3, file4]])
    expect(@duplicates_by_digest_resolver).to receive(:resolve).with([file1, file2]).and_return([])
    expect(@duplicates_by_digest_resolver).to receive(:resolve).with([file3, file4]).and_return([file3, file4])
    expect(@duplicate_finder.find).to eq([[file3, file4]])
  end

end
