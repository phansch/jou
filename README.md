# Jou
[![Code Climate](https://codeclimate.com/github/phansch/jou.png)](https://codeclimate.com/github/phansch/jou)

Jou is a simple command line utility that helps with maintaining a journal file in markdown syntax.

I personally use jou together with git hooks. Whenever a commit is created, 
jou automatically creates a new journal entry for the commit.

### Installation

    $ gem install jou

### Configuration
The first time you start jou, you will have to specify the path to your journal file.  
Alternatively, you can edit `~/.jou`

### Usage

    $ jou -h      
    Usage: jou [options]

    Jou is a simple command line utility that helps with maintaining a journal file in markdown syntax.

    v0.2.0

    Options:
        -h, --help                       Show command line help
        -a, --add-entry VALUE            Add an entry
        -s, --set-perm VALUE             Set a new default file to write to and read from.
        -t, --set-temp VALUE             Set a file to write to without overwriting the config file.
            --version                    Show help/version info

Running jou without options will print the most recent entries from the journal file specified in the config.

--- 

Adding a journal entry is as simple as:

    $ jou -a "Today I tried out jou"

Setting a new journal file to use:

    $ jou -s "/home/<user>/Documents/Journal.md"

Note that you will have to specify the absolute path here.

### Output format

    ### 13.10.03
     * Tried out jou
     * Completed task X
     * Wrote a blog post

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request