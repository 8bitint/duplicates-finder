class DuplicatesPrinter

  def print(duplicates)
    puts 'Duplicates:'

    duplicates.each do |fileinfo|
      puts "\t#{fileinfo.path}"
    end
    puts
  end
end