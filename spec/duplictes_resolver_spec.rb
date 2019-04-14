require 'duplicates_resolver.rb'

RSpec.describe DuplicatesResolver do

  before(:each) do
    @content_resolver_strategy = instance_double('ContentDuplicationResolverStrategy')
    @digest_resolver_strategy = instance_double('DigestDuplicationResolverStrategy')
    @duplicates_resolver = DuplicatesResolver.new(@content_resolver_strategy, @digest_resolver_strategy)
  end

  it 'selects the faster content comparing strategy when faced with 2 files' do
    file_group = instance_double('FileGroup', size: 2)
    expect(@content_resolver_strategy).to receive(:resolve).with(file_group).and_return([])
    expect(@digest_resolver_strategy).to_not receive(:resolve)

    @duplicates_resolver.resolve(file_group)
  end

  it 'selects the slower digest comparing strategy when encountering > 2 files' do
    file_group = instance_double('FileGroup', size: 7)
    expect(@content_resolver_strategy).to_not receive(:resolve)
    expect(@digest_resolver_strategy).to receive(:resolve).with(file_group).and_return([])

    @duplicates_resolver.resolve(file_group)
  end

end

