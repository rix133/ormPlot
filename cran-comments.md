## Resubmission
This is a resubmission. In this version I have re-examined the vignette:

* fixed spelling errors in the vignette
* Have done nothing about the CRAN WARNING: "Error: Vignette re-building failed."
This is because, I have been unable to reproduce this error on any of the 
environments listed under Test  environments.
All this points that this is a false positive warning.

I also changed the LICENSE file to comply with CRAN requirements.

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

The note is about maintainer e-mail that is just reminders to 
check those fields. 

## Downstream dependencies
I have not run R CMD check on downstream dependencies of ormPlot, as there 
are no strong reverse dependencies to be checked.
