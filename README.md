# jtime
A simple time parsing library.

## limitations
This isn't and isn't intended to be a general time library. Janet's standard library doesn't have functions for generating or parsing strings representing time and date, but this module only meets the very specific need I had.

## why
This could easily have been included as a module in the project it is intended for, but I wanted to explore janet's module system. Since this has no external deps it was a good simple test project.

There are also simpler ways to implement it but I wanted to use a PEG as is encouraged in janet. Most janet PEG examples I can find are either trivial or are complex grammars of full & complex languages. This is a simple case of using a PEG to parse-and-validate a small DSL, which I think they're well suited to.
