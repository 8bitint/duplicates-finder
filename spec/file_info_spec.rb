require 'file_info.rb'

RSpec.describe FileInfo do

  it 'does not calculate digest when not asked' do
    FileInfo.new('a-file.name', 8765)
    expect(Digest::MD5).not_to receive(:file)
  end

  it 'calculates digest when required' do
    expect(Digest::MD5).to receive(:file).and_return('digest-for-file')
    file_info = FileInfo.new('a-file.name', 8765)
    expect(file_info.digest).to eq('digest-for-file')
  end
end
