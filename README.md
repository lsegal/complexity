Complexity
==========

Written by Loren Segal in 2009

SYNOPSIS
--------

Calculates the McCabe [cyclomatic complexity][1] index of the methods in your Ruby code.
The calculation is a basic `NUMBER_OF_BRANCHES + 1` calculation which can be used 
this calculation to approximate the minimum number of test cases for each of
your methods ([complexity should equal number of test cases][3]). You can also use
this value to find overly complex method and refactor them into simpler ones.

Some more reading can be found at [http://www.linuxjournal.com/article/8035][1].

USAGE
-----

* Requires Ruby 1.9.x and [YARD][3]

Syntax: `ruby complexity.rb [--csv] GLOB_OF_FILES` 

If you want CSV output, add --csv. `GLOB_OF_FILES` defaults to `lib/**/*.rb`.

[1]: http://en.wikipedia.org/wiki/Cyclomatic_complexity "Cyclomatic Complexity"
[2]: http://users.csc.calpoly.edu/~jdalbey/206/Lectures/BasisPathTutorial/index.html "Basis Path Testing"
[3]: http://yard.soen.ca "Yay! A Ruby Documentation Tool"
[4]: http://www.linuxjournal.com/article/8035