require "pullable/version"
require "fileutils"

SKIPPED_DIRECTORIES = ['.DS_Store']

module Pullable

  def self.process!(root)
    pulled, skipped, failed = [], [], []

    raise ArgumentError.new("Please pass a root directoy!") if root.nil?
    raise ArgumentError.new("Please pass a valid root directoy!") unless File.directory?(root)

    Dir.foreach(root) do |directory|
      if File.directory?(directory)
        unless SKIPPED_DIRECTORIES.include?(directory)
          FileUtils.cd(directory)

          if File.directory?('.git')
            puts "Pulling:\t#{directory}"
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

    puts "Pulled:\t\t#{pulled.inspect}" unless pulled.empty?
    puts "Skipped:\t#{skipped.inspect}" unless skipped.empty?
    puts "Failed:\t\t#{failed.inspect}" unless failed.empty?
  end
end