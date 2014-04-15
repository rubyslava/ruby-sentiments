task :setup do
  puts 'Setting up example config files'

  src = 'config/*.example'

  FileList[src].each do |example_filename|
    destination = example_filename.gsub(/\.example$/, '')

    if File.exist?(destination)
      puts "#{destination} Already exists. Skipping"
    else
      puts "Copying #{example_filename} To #{destination}"
      cp example_filename, destination
    end
  end
end
