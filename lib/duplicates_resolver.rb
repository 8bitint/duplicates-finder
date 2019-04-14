class DuplicatesResolver

  def initialize(content_resolver_strategy, digest_resolver_strategy)
    @content_resolver_strategy = content_resolver_strategy
    @digest_resolver_strategy = digest_resolver_strategy
  end

  # @return array of confirmed candidate groups
  def resolve(candidate_group)
    candidate_group.size == 2 ? @content_resolver_strategy.resolve(candidate_group) : @digest_resolver_strategy.resolve(candidate_group)
  end

end