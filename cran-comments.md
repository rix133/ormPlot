## Resubmission
This is a resubmission. In this version I have re-examined the vignette:

* fixed spelling errors in the vignette
* Have replaced the function call ´forestplot´ with a equivalent S3 method
to fix the reason for the CRAN WARNING: "Error: Vignette re-building failed."
However, I have been unable to reproduce this error on any of the 
environments listed under Test  environments, so it is also possible that it was
 a false positive warning.

I have changed the LICENSE file to comply with CRAN requirements.

## Test environments
* local windows 7 install, R 3.5.3
* local windows 7 install, R 3.6.0
* local ubuntu 18.04, R 3.6.0
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
