# packman-sloc
Count PackManager SLoC (Source Lines of Code)

Start by using using `git` to get the correct version of PackManager source code into the `sloc` src directory.
This directory is generated using the expression: `ENV['PACKMANGER_DIR']/sloc` so you may have to set an environment variable.

Basic Sequence of Rake tasks to run

1. `rake sloc:capture`
1. `rake sloc:report\[9,""\]`
1. `rake sloc:report\[9,"Ruby"\]`

All work is done with these Rake tasks:

rake sloc:capture  
> Capture a snapshot of PackManager source code metrics

rake sloc:clear[snapshot_id]
> Clear PackManager source code metrics for the specified snapshot  

rake sloc:generate
> Generate PackManager source code metrics  

rake sloc:import
> Import generated PackManager source code metrics  

rake sloc:languages
> List all languages found in the PackManager source code metrics  

rake sloc:list
> List all runs of PackManager source code metrics  

rake sloc:report[snapshot_id,languages]
> Generate a report of PackManager source code metrics for the specified snapshot and languages

