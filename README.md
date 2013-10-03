# Jou
Jou is a simple command line utility that helps with maintaining a journal file in markdown syntax.

I personally use jou together with [taskwarrior](http://taskwarrior.org). Whenever a task is completed, 
jou automatically creates a new journal entry for the finished task.

### Installation
    $ gem install jou

### Configuration
The first time you start jou, you will have to specify the path to your journal file.  
Alternatively, you can edit `~/.config/jou/config.yml`
### Usage
    $ jou -h
    Usage: jou [options]
        -a description                   Add an entry
        -f file                          Temporarily use another journal file  

Adding a journal entry is as simple as:

    $ jou -a "Today I tried out jou"

### Output format

    ### 13.10.03
     * Tried out jou
     * Completed task X
     * Wrote a blog post

### Coming maybe
 * List and filter journal entries
