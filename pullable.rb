require 'fileutils'

pulled, skipped, failed = [], [], []

root = ARGF.argv[0]

raise ArgumentError.new("Please pass a root directoy!") if root.nil?
raise ArgumentError.new("Please pass a valid root directoy!") unless File.directory?(root)

Dir.foreach(root) do |directory|
  if File.directory?(directory)
    FileUtils.cd(directory)

    if File.directory?('.git')
      puts "Pulling: #{directory}"
      `git pull`
      `git remote prune origin`
    end

    FileUtils.cd(root)

    unless $?.success?
      failed << directory
    else
      pulled << directory
    end
  else
    skipped << directory
  end
end

puts "Pulled\t#{pulled.inspect}"
puts "Skipped\t#{skipped.inspect}"
puts "Failed\t#{failed.inspect}"
