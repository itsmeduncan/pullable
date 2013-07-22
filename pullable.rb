require 'fileutils'

pulled, skipped, failed = [], [], []

root = ARGF.argv[0]

raise ArgumentError.new("Please pass a root directoy!") if root.nil?
raise ArgumentError.new("Please pass a valid root directoy!") unless File.directory?(root)

SKIPPED_DIRECTORIES = ['.DS_Store']

Dir.foreach(root) do |directory|
  if File.directory?(directory)
    unless SKIPPED_DIRECTORIES.include?(directory)
      FileUtils.cd(directory)

      if File.directory?('.git')
        puts "Pulling: #{directory}"
        `git fetch -p`
        `git merge --ff-only origin/master`
      end

      unless $?.success?
        failed << directory
      else
        pulled << directory
      end

      FileUtils.cd(root)
    end
  else
    skipped << directory
  end
end

puts "Pulled\t#{pulled.inspect}"
puts "Skipped\t#{skipped.inspect}"
puts "Failed\t#{failed.inspect}"
