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
        if File.directory?(directory)
          unless SKIPPED_DIRECTORIES.include?(directory)
            FileUtils.cd(directory)

            if Dir.exists?('.git')
              Pullable::Processor.update!(method, directory)
            end

            FileUtils.cd(path)
          end
        end
      end
    end

    def self.process!(path, method = 'merge')
      new(path, method).process!
    end

  end
end