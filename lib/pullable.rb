require 'pullable/directory'
require 'pullable/version'

module Pullable

  def self.process!(path, method = 'merge')
    Pullable::Directory.process!(path, method)
  end

end