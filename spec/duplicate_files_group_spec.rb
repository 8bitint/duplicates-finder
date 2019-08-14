require 'file'
require 'duplicate_files_group'

module Duplicates

  RSpec.describe DuplicateFilesGroup do

    it 'supports initialisation with no arguments' do
      duplicate_files_group = DuplicateFilesGroup.new
      expect(duplicate_files_group.size).to eq(0)
      expect(duplicate_files_group.files).to eq([])
    end

    it 'supports initialisation with a single file' do
      duplicate_files_group = DuplicateFilesGroup.new(['file1'])
      expect(duplicate_files_group.size).to eq(1)
      expect(duplicate_files_group.files).to eq(['file1'])
    end

    it 'can have files added to it' do
      duplicate_files_group = DuplicateFilesGroup.new
      duplicate_files_group.add('file1')
      expect(duplicate_files_group.size).to eq(1)
      expect(duplicate_files_group.files).to eq(['file1'])
    end

    it 'equality does not care about the order of elements in the group' do
      group1 = DuplicateFilesGroup.new(['file1', 'file2'])
      group2 = DuplicateFilesGroup.new(['file2', 'file1'])
      
      expect(group1).to eq(group2)
    end

    context 'a duplicate file group' do

      before(:each) do
        @file1 = Duplicates::File.new('file1', 123)
        @file2 = Duplicates::File.new('file2', 123)
        @file3 = Duplicates::File.new('file3', 123)

        @duplicate_files_group = DuplicateFilesGroup.new([@file1, @file2])
      end

      it 'knows when a different file doe not fit the group' do
        expect(FileUtils).to receive(:compare_file).with('file1', 'file3').and_return(false)

        expect(@duplicate_files_group.same?(@file3)).to eq(false)
      end

      it 'knows when a candidate file matches the group' do
        expect(FileUtils).to receive(:compare_file).with('file1', 'file3').and_return(true)

        expect(@duplicate_files_group.same?(@file3)).to eq(true)
      end
    end

  end

end
