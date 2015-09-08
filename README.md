# PackManager Source Lines of Code

Make sure that you have installed the `cloc` command line tool. If you're on OS X and using Homebrew you can use the
command: `brew install cloc`. Or download from http://cloc.sourceforge.net.

Start by using using `git` to clone a version of PackManager source code into a directory of your choosing. This
directory is referenced using the expression: `ENV['SLOC_DIR']` so you must set an environment variable that points
to the directory where you have cloned the PackManager source code. Note: if you want to generate metrics for the
latest version of PackManager simply define the `SLOC_DIR` environment variable to point to the `dev` branch.

**Adjusting Which Directories Are Counted**

1. `packman_directories.yml`
1. `packman_filters.yml`

**Basic Sequence of Rake Tasks to Run**

1. `rake sloc:capture sloc:report`

For more control use one of these report forms to list a specific snapshot and language:

1. `rake sloc:list`
1. `rake sloc:report\[<snapshot_id>\]`
1. `rake sloc:report\[<snapshot_id>,"Ruby"\]`
1. `rake sloc:report\[<snapshot_id>,"Ruby,Javascript"\]`

All work is done with these Rake tasks:

`rake sloc:capture`
> Capture a snapshot of PackManager source code metrics

`rake sloc:clear[<snapshot_id>]`
> Clear PackManager source code metrics for the specified snapshot

`rake sloc:generate`
> Generate PackManager source code metrics

`rake sloc:import`
> Import generated PackManager source code metrics

`rake sloc:languages`
> List all languages found in the PackManager source code metrics

`rake sloc:list`
> List all runs of PackManager source code metrics

`rake sloc:report[<snapshot_id>,languages]`
> Generate a report of PackManager source code metrics for the specified snapshot and languages
