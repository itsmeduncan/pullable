require 'pullable/directory'
require 'pullable/version'

module Pullable

  def self.process!(path, method = 'merge')
    if method == '' || method == nil
      method = 'merge'
    end

    Pullable::Directory.process!(path, method)
  end

end