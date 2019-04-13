require 'duplicate_candidates_tracker.rb'

RSpec.describe DuplicateCandidatesTracker do

  before(:each) do
    file1 = double('File', size: 123)
    file2 = double('File', size: 456)
    file3 = double('File', size: 789)
    file4 = double('File', size: 456)
    file5 = double('File', size: 123)
    file6 = double('File', size: 123)

    @expected_candidates = {
      123 => [file1, file5, file6],
      456 => [file2, file4]
    }

    @duplicate_candidates_tracker = DuplicateCandidatesTracker.new
    [file1, file2, file3, file4, file5, file6].each do |file|
      @duplicate_candidates_tracker.add(file)
    end
  end

  context 'given a list of files' do
    it 'considers only those files with identical sizes as possible duplications' do
      expect(@duplicate_candidates_tracker.candidates).to eq(@expected_candidates)
    end
  end
end