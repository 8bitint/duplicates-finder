require 'duplicate_finder.rb'

RSpec.describe DuplicateFinder do

  before(:each) do
    @arguments_parser = double('ArgumentsParser')
    @file_iterator = double('FileIterator')
    @duplicate_candidates_tracker = double('DuplicateCandidatesTracker')
    @duplicate_finder = DuplicateFinder.new(@arguments_parser, @file_iterator, @duplicate_candidates_tracker)

    allow(@arguments_parser).to receive(:error).and_return(nil)
    allow(@file_iterator).to receive(:foreach_file)
    allow(@arguments_parser).to receive(:options).and_return({ directory: 'DIRECTORY' })
  end

  it 'stops and offers help when command line parsing fails' do
    expect(@arguments_parser).to receive(:error).twice.and_return('ERROR MESSAGE')

    expect { @duplicate_finder.run }
      .to raise_error(SystemExit)
      .and output("ERROR MESSAGE\n").to_stdout
  end

  it 'quietly exits when command line parsing succeeds' do
    expect(@arguments_parser).to receive(:error).and_return(nil)

    expect { @duplicate_finder.run }.to_not output.to_stdout
  end

  it 'orchestrates tracking of candidate files in the given diretory' do
    file_to_track = 'not a real file'

    expect(@file_iterator).to receive(:foreach_file).with('DIRECTORY').and_yield(file_to_track)
    expect(@duplicate_candidates_tracker).to receive(:add).with(file_to_track)
    @duplicate_finder.run
  end
end
