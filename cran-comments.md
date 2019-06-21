## Resubmission
This is a resubmission. In this version I have re-examined the vignette error
and hopefully resolved the issue. The issue seemed to be in having only the 
default method for forestplot and missing the method for class rms.summary.

However, I have been unable to reproduce this error on any of the 
environments listed under Test environments, so it is also possible that I still
misunderstood the problem. Therefore, I also changed the function calls in
the vignette to call the method explicitly.

## Test environments
* local windows 7 install, R 3.5.3
* local windows 7 install, R 3.6.0
* local ubuntu 18.04, R 3.6.0
* winbuilder windows-x86_64-w64-mingw32 (r-devel)
* R-hub windows-x86_64-devel (r-devel)
* R-hub ubuntu-gcc-release (r-release)
* R-hub fedora-clang-devel (r-devel)
* R-hub debian-gcc-devel (r-devel)

## R CMD check results
There were 1 NOTE, 0 ERRORs and 0 WARNINGs.
On rhub windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release) and
fedora-clang-devel (r-devel).

The note is about maintainer e-mail that is just a reminder to 
check those fields for a new submission. 

## Downstream dependencies
I have not run R CMD check on downstream dependencies of ormPlot, as there 
are no strong reverse dependencies to be checked.
