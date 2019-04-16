require 'duplicates_finder'
require 'same_sized_files_group'

module Duplicates

  RSpec.describe DuplicatesFinder do

    before(:each) do
      @file_iterator = instance_double('FileIterator')
      @duplicate_file_candidates = instance_double('DuplicateFileCandidates')
      @duplicate_finder = DuplicatesFinder.new(@file_iterator, @duplicate_file_candidates)
    end

    it 'orchestrates identification of candidates and duplicates' do
      file_to_track = 'not a real file'

      file1 = instance_double('File')
      file2 = instance_double('File')
      group_of_unique_files = instance_double('SameSizedFilesGroup', duplicates: [])
      expected_duplicates = DuplicateFilesGroup.new([file1, file2])
      group_of_duplicate_files = instance_double('SameSizedFilesGroup', duplicates: [expected_duplicates])

      expect(@file_iterator).to receive(:each).and_yield(file_to_track)
      expect(@duplicate_file_candidates).to receive(:add).with(file_to_track)
      expect(@duplicate_file_candidates).to receive(:candidates).and_return([group_of_unique_files, group_of_duplicate_files])
      expect(@duplicate_finder.duplicates).to eq([expected_duplicates])
    end
  end

end