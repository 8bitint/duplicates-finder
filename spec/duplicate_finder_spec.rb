require 'duplicate_finder.rb'

RSpec.describe DuplicateFinder do

  before(:each) do
    @arguments_parser = double('ArgumentsParser')
    @duplicate_finder = DuplicateFinder.new(@arguments_parser)
  end

  it 'stops and offers help when command line parsing fails' do
    expect(@arguments_parser).to receive(:error).twice.and_return('ERROR MESSAGE')

    expect { @duplicate_finder.run }
      .to raise_error(SystemExit)
      .and output("ERROR MESSAGE\n").to_stdout
  end

  it 'quietly exits when command line parsing succeedds' do
    expect(@arguments_parser).to receive(:error).and_return(nil)

    expect { @duplicate_finder.run }.to_not output.to_stdout
  end
end
