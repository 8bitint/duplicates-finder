class DuplicatesPrinter

  def print(duplicates_group)
    puts 'Duplicates:'

    duplicates_group.files.each do |fileinfo|
      puts "\t#{fileinfo.path}"
    end
    puts
  end
end