require 'yaml'

class Pullable::Processor

  CONFIG_FILE = ".pullable.yml"

  attr_reader :method, :directory, :options, :branch

  def initialize(method, directory, options = {})
    @method    = method
    @directory = directory
    @options   = options

    @branch    = `git rev-parse --abbrev-ref HEAD` || 'master'
  end

  def self.update!(method, directory)
    options   = File.exists?(CONFIG_FILE) ? YAML.load(File.read(CONFIG_FILE)) : {}
    processor = new(method, directory, options)

    if processor.options['mirror']
      processor.mirror!(options)
    else
      processor.update!(options)
    end
  end

  def mirror!(options = {})
    remote = options['mirror']['remote'] rescue 'upstream'
    run "git pull #{remote} #{branch} && git push origin #{branch}"
  end

  def update!(options = {})
    run "git fetch -p && #{command}"
  end

  def run(command)
    puts "Updating:\t#{directory}"
    system "#{command} > /dev/null"
  end

  def command
    case method
    when 'merge'
      "git merge --ff-only origin/#{branch}"
    when 'pull'
      "git pull origin #{branch}"
    else
      raise NotImplementedError
    end
  end
end
