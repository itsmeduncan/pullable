require 'fileutils'

module Pullable
  class Directory

    VALID_METHODS = ['pull', 'merge']
    SKIPPED_DIRECTORIES = ['.DS_Store']

    attr_reader :path, :method

    def initialize(path, method)
      unless File.directory?(path)
        raise ArgumentError.new('Please pass a directory that exists!')
      end

      unless VALID_METHODS.include?(method)
        raise ArgumentError.new("#{method} cannot be used to update the repo!")
      end

      @path   = path
      @method = method
    end

    def process!
      Dir.foreach(path) do |directory|
        raise directory.inspect
        if File.directory?(directory)
          unless SKIPPED_DIRECTORIES.include?(directory)
            FileUtils.cd(directory)

            if File.directory?(File.join(directory, '.git'))
              update!
            end

            FileUtils.cd(path)
          end
        end
      end
    end

    def self.process!(path, method = 'merge')
      new(path, method).process!
    end

    def update!
      system "git fetch -p && #{command} > /dev/null"
    end

    def command
      case @method
      when 'merge'
        'git merge --ff-only origin/master'
      when 'pull'
        'git pull origin master'
      else
        raise NotImplementedError
      end
    end
  end
end