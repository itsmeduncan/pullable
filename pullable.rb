require 'fileutils'

pulled, skipped, failed = [], [], []

root = ARGF.argv[0]

raise ArgumentError.new("Please pass a root directoy!") if root.nil?

Dir.foreach(root) do |directory|
  if File.directory?(directory)
    puts "Pulling: #{directory}"
    FileUtils.cd(directory)

    `git pull`
    `git remote prune origin`

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
