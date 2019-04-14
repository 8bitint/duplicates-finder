require 'fileutils'

class ContentDuplicationResolverStrategy

  # @return array of confirmed candidate groups
  def resolve(candidate_group)
    if candidate_group.size != 2
      raise 'ContentDuplicationResolverStrategy only supports groups of 2'
    end
    same = FileUtils.compare_file(candidate_group.files.first.path,
                                  candidate_group.files.last.path)
    same ? [candidate_group] : []
  end

end