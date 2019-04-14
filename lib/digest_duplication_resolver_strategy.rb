require 'digest'
require_relative 'file_group'

class DigestDuplicationResolverStrategy

  # @return array of confirmed candidate groups
  def resolve(candidate_group)
    group_by_digest(candidate_group)
        .select {|_key, values| values.size > 1}
        .values
  end

  def group_by_digest(candidate_group)
    new_groups = {}

    candidate_group.files.each do |file_info|
      digest = Digest::MD5.file(file_info.path).to_s
      group = new_groups.fetch(digest, FileGroup.new)
      group.add(file_info)
      new_groups[digest] = group
    end

    new_groups
  end
end