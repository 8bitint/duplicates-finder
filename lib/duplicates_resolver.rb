class DuplicatesResolver

  # @return array of confirmed candidate groups
  def resolve(candidate_group)
    group_by_digest(candidate_group)
        .select {|_key, values| values.size > 1}
        .values
  end

  def group_by_digest(candidate_group)
    new_groups = {}

    candidate_group.files.each do |file_info|
      group = new_groups.fetch(file_info.digest.to_s, FileGroup.new)
      group.add(file_info)
      new_groups[file_info.digest.to_s] = group
    end

    new_groups
  end

end