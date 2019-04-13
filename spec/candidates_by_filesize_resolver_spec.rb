require 'candidates_by_filesize_resolver.rb'

RSpec.describe CandidatesByFilesizeResolver do

  before(:each) do
    file1 = double('File', size: 123)
    file2 = double('File', size: 456)
    file3 = double('File', size: 789)
    file4 = double('File', size: 456)
    file5 = double('File', size: 123)
    file6 = double('File', size: 123)

    @expected_candidates = [[file1, file5, file6], [file2, file4]]

    @candidates_by_filesize_resolver = CandidatesByFilesizeResolver.new
    [file1, file2, file3, file4, file5, file6].each do |file|
      @candidates_by_filesize_resolver.add(file)
    end
  end

  context 'given a list of files' do
    it 'considers only those files with identical sizes as possible duplications' do
      expect(@candidates_by_filesize_resolver.candidate_groups).to eq(@expected_candidates)
    end
  end
end