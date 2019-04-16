require 'duplicate_file_candidates'

module Duplicates

  RSpec.describe DuplicateFileCandidates do

    before(:each) do
      file1 = instance_double('File', size: 123)
      file2 = instance_double('File', size: 456)
      file3 = instance_double('File', size: 789)
      file4 = instance_double('File', size: 456)
      file5 = instance_double('File', size: 123)
      file6 = instance_double('File', size: 123)

      files_with_123_bytes = SameSizedFilesGroup.new
      files_with_123_bytes.add(file1)
      files_with_123_bytes.add(file5)
      files_with_123_bytes.add(file6)

      files_with_456_bytes = SameSizedFilesGroup.new
      files_with_456_bytes.add(file2)
      files_with_456_bytes.add(file4)

      @expected_candidates = [files_with_123_bytes, files_with_456_bytes]

      @duplicate_file_candidates = DuplicateFileCandidates.new
      [file1, file2, file3, file4, file5, file6].each do |file|
        @duplicate_file_candidates.add(file)
      end
    end

    context 'given a list of candidate file groups' do
      it 'only considers file groups as duplication candidates when it holds more than one file' do
        expect(@duplicate_file_candidates.candidates).to eq(@expected_candidates)
      end
    end
  end

end