require 'rubygems'
require 'fileutils'

pulled, skipped, failed = [], [], {}

root = ARGF.argv[0]

raise ArgumentError.new("Please pass a root directoy!") if root.nil?

Dir.foreach(root) do |directory|
  if File.directory?(directory)
    pulled << directory

    FileUtils.cd(directory)
    output = `git pull`
    FileUtils.cd(root)

    unless $?.success?
      failed[directory.to_sym] = output
    else
      print '.'
      $stdout.flush
    end
  else
    skipped << directory
  end
end

puts "Pulled\t#{pulled.inspect}"
puts "Skipped\t#{skipped.inspect}"
puts "Failed\t#{failed.inspect}"
