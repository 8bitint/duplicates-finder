require 'same_sized_files_group'

RSpec.describe SameSizedFilesGroup do

  context 'given no files' do
    before(:each) do
      @same_sized_files_group = SameSizedFilesGroup.new
    end

    it 'is empty' do
      expect(@same_sized_files_group.size).to eq(0)
    end

    it 'returns no duplicates' do
      expect(@same_sized_files_group.duplicates).to eq([])
    end
  end

  context 'given 1 file' do
    before(:each) do
      file = instance_double('FileInfo')
      @same_sized_files_group = SameSizedFilesGroup.new([file])
    end

    it 'contains 1 file' do
      expect(@same_sized_files_group.size).to eq(1)
    end

    it 'contains 0 duplicates' do
      expect(@same_sized_files_group.duplicates).to eq([])
    end
  end

  context 'given 2 files that are identical' do
    before(:each) do
      @file1 = instance_double('FileInfo', path: '/one')
      @file2 = instance_double('FileInfo', path: '/two')
      @same_sized_files_group = SameSizedFilesGroup.new([@file1, @file2])
    end

    it 'contains 2 files' do
      expect(@same_sized_files_group.size).to eq(2)
    end

    it 'has 2 duplicates' do
      expect(FileUtils).to receive(:compare_file).with('/one', '/two').and_return(true)
      expected_duplicate_files = DuplicateFilesGroup.new([@file1, @file2])
      expect(@same_sized_files_group.duplicates).to eq([expected_duplicate_files])
    end
  end

  context 'given 2 files that are not identical' do
    before(:each) do
      @file1 = instance_double('FileInfo', path: '/one')
      @file2 = instance_double('FileInfo', path: '/two')
      @same_sized_files_group = SameSizedFilesGroup.new([@file1, @file2])

      expect(FileUtils).to receive(:compare_file).with('/one', '/two').and_return(false)
    end

    it 'contains 0 duplicates' do
      expect(@same_sized_files_group.duplicates).to eq([])
    end
  end

  context 'given 3 files that are identical' do
    before(:each) do
      @file1 = instance_double('FileInfo', path: 'file1')
      @file2 = instance_double('FileInfo', path: 'file2')
      @file3 = instance_double('FileInfo', path: 'file3')
      @same_sized_files_group = SameSizedFilesGroup.new([@file1, @file2, @file3])

      expect(Digest::MD5).to receive(:file).with('file1').and_return('AAAA')
      expect(Digest::MD5).to receive(:file).with('file2').and_return('AAAA')
      expect(Digest::MD5).to receive(:file).with('file3').and_return('AAAA')
    end

    it 'contains 3 duplicates' do
      expected_duplicate_files = DuplicateFilesGroup.new([@file1, @file2, @file3])
      expect(@same_sized_files_group.duplicates).to eq([expected_duplicate_files])
    end
  end

  context 'given 3 files, 2 of which are identical' do
    before(:each) do
      @file1 = instance_double('FileInfo', path: 'file1') # digest = BBBB
      @file2 = instance_double('FileInfo', path: 'file2') # digest = CCCC
      @file3 = instance_double('FileInfo', path: 'file3') # digest = BBBB
      @same_sized_files_group = SameSizedFilesGroup.new([@file1, @file2, @file3])

      expect(Digest::MD5).to receive(:file).with('file1').and_return('BBBB')
      expect(Digest::MD5).to receive(:file).with('file2').and_return('CCCC')
      expect(Digest::MD5).to receive(:file).with('file3').and_return('BBBB')
    end

    it 'contains 2 duplicates' do
      expected_duplicate_files = DuplicateFilesGroup.new([@file1, @file3])
      expect(@same_sized_files_group.duplicates).to eq([expected_duplicate_files])
    end
  end

  context 'given 3 files that are not identical' do
    before(:each) do
      @file1 = instance_double('FileInfo', path: 'file1') # digest = BBBB
      @file2 = instance_double('FileInfo', path: 'file2') # digest = CCCC
      @file3 = instance_double('FileInfo', path: 'file3') # digest = DDDD
      @same_sized_files_group = SameSizedFilesGroup.new([@file1, @file2, @file3])

      expect(Digest::MD5).to receive(:file).with('file1').and_return('AAAA')
      expect(Digest::MD5).to receive(:file).with('file2').and_return('BBBB')
      expect(Digest::MD5).to receive(:file).with('file3').and_return('CCCC')
    end

    it 'contains 0 duplicates' do
      expect(@same_sized_files_group.duplicates).to eq([])
    end
  end

  context 'given 4 files that are 2 identical pairs' do
    before(:each) do
      @file1 = instance_double('FileInfo', path: 'file1') # digest = BBBB
      @file2 = instance_double('FileInfo', path: 'file2') # digest = CCCC
      @file3 = instance_double('FileInfo', path: 'file3') # digest = CCCC
      @file4 = instance_double('FileInfo', path: 'file4') # digest = BBBB
      @same_sized_files_group = SameSizedFilesGroup.new([@file1, @file2, @file3, @file4])

      expect(Digest::MD5).to receive(:file).with('file1').and_return('BBBB')
      expect(Digest::MD5).to receive(:file).with('file2').and_return('CCCC')
      expect(Digest::MD5).to receive(:file).with('file3').and_return('CCCC')
      expect(Digest::MD5).to receive(:file).with('file4').and_return('BBBB')
    end

    it 'contains 2 pairs of duplicates' do
      expected_duplicate_files1 = DuplicateFilesGroup.new([@file1, @file4])
      expected_duplicate_files2 = DuplicateFilesGroup.new([@file2, @file3])
      expect(@same_sized_files_group.duplicates).to eq([expected_duplicate_files1, expected_duplicate_files2])
    end
  end

end
