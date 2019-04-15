require 'duplicate_file_candidates'

RSpec.describe DuplicateFileCandidates do

  before(:each) do
    file_info1 = instance_double('FileInfo', size: 123)
    file_info2 = instance_double('FileInfo', size: 456)
    file_info3 = instance_double('FileInfo', size: 789)
    file_info4 = instance_double('FileInfo', size: 456)
    file_info5 = instance_double('FileInfo', size: 123)
    file_info6 = instance_double('FileInfo', size: 123)

    files_with_123_bytes = SameSizedFilesGroup.new
    files_with_123_bytes.add(file_info1)
    files_with_123_bytes.add(file_info5)
    files_with_123_bytes.add(file_info6)

    files_with_456_bytes = SameSizedFilesGroup.new
    files_with_456_bytes.add(file_info2)
    files_with_456_bytes.add(file_info4)

    @expected_candidates = [files_with_123_bytes, files_with_456_bytes]

    @duplicate_file_candidates = DuplicateFileCandidates.new
    [file_info1, file_info2, file_info3, file_info4, file_info5, file_info6].each do |file_info|
      @duplicate_file_candidates.add(file_info)
    end
  end

  context 'given a list of candidate file groups' do
    it 'only considers file groups as duplication candidates when it holds more than one file' do
      expect(@duplicate_file_candidates.candidates).to eq(@expected_candidates)
    end
  end
end