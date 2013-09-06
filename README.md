# Pullable

[![Build Status](https://travis-ci.org/itsmeduncan/pullable.png?branch=master)](https://travis-ci.org/itsmeduncan/pullable)

Loop over a directory of Git repositories, fetch, and fast-forward merge from
origin.

## Installation

Add this line to your application's Gemfile:

    gem 'pullable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pullable

## Usage

    ls ~/Projects
    foo    bar    .DS_Store

    pullable ~/Projects
    # cd ~/Projects
    # cd ~/Projects/foo
    # git fetch -p && git merge --ff-only origin/master
    # cd ~/Projects/bar
    # git fetch -p && git merge --ff-only origin/master
     
    pullable ~/Projects pull
    # cd ~/Projects
    # cd ~/Projects/foo
    # git fetch -p && git pull origin master
    # cd ~/Projects/bar
    # git fetch -p && git pull origin master

## TODO

* Logging
* Finer grain command line options
* Grit?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
