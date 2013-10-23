# Jou
Jou is a simple command line utility that helps with maintaining a journal file in markdown syntax.

I personally use jou together with [taskwarrior](http://taskwarrior.org). Whenever a task is completed, 
jou automatically creates a new journal entry for the finished task.

### Installation
    $ gem install jou

### Configuration
The first time you start jou, you will have to specify the path to your journal file.  
Alternatively, you can edit `~/.jou`
### Usage
    $ jou -h
    Usage: jou [options]
        -a, --add-entry String           Add an entry
        -s, --set-journal path/to/file   Set a new default file to write to and read from
        -h, --help, --usage              Show this message


Adding a journal entry is as simple as:

    $ jou -a "Today I tried out jou"

Setting a new journal file to use:

    $ jou --set-journal "/home/user/Documents/Journal.md"

Note that the ~ character is currently not supported. Specify the absolute path here.
### Output format

    ### 13.10.03
     * Tried out jou
     * Completed task X
     * Wrote a blog post

### Coming maybe
 * List and filter journal entries
