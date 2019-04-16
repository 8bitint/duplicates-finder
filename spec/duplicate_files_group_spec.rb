require 'duplicate_files_group'

module Duplicates

  RSpec.describe DuplicateFilesGroup do

    it 'supports initialisation with files' do
      duplicate_files_group = DuplicateFilesGroup.new(['file1', 'file2'])
      expect(duplicate_files_group.size).to eq(2)
      expect(duplicate_files_group.duplicates).to eq(['file1', 'file2'])
    end

    it 'can have files added to it' do
      duplicate_files_group = DuplicateFilesGroup.new
      expect(duplicate_files_group.size).to eq(0)
      expect(duplicate_files_group.duplicates).to eq([])

      duplicate_files_group.add('file')
      expect(duplicate_files_group.size).to eq(1)
      expect(duplicate_files_group.duplicates).to eq(['file'])
    end

    it 'equality does not care about the order of elements in the group' do
      group1 = DuplicateFilesGroup.new(['file1', 'file2'])
      group2 = DuplicateFilesGroup.new(['file2', 'file1'])

      expect(group1).to eq(group2)
    end
  end

end