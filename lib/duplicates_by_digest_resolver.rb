class DuplicatesByDigestResolver

  def resolve(candidate_group)
    duplicates_by_digest = group_by_digest(candidate_group).reject do |_, values|
      values.size == 1
    end
    convert_to_groups(duplicates_by_digest)
  end

  private

  def group_by_digest(candidate_group)
    digest_to_file_info = {}

    candidate_group.each do |file_info|
      files_with_this_digest = digest_to_file_info.fetch(file_info.digest.to_s, [])
      files_with_this_digest.push(file_info)
      digest_to_file_info[file_info.digest.to_s] = files_with_this_digest
    end

    digest_to_file_info
  end

  def convert_to_groups(duplicates_by_digest)
    duplicate_groups = []
    duplicates_by_digest.each_value do |value|
      duplicate_groups.push(value)
    end

    duplicate_groups
  end

end