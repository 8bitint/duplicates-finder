require 'file'

module Duplicates

  RSpec.describe File do
    it 'uses path to compare itself against other files' do
      file1 = Duplicates::File.new('1st', 0)
      file2 = Duplicates::File.new('2nd', 0)
      file_same = Duplicates::File.new('same', 0)

      expect(file1 <=> file2).to eq(-1)
      expect(file_same <=> file_same).to eq(0)
      expect(file2 <=> file1).to eq(1)
    end
  end

end