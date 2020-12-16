## Resubmission
This is a resubmission of an existing package. In this version I have fixed
the problem that a suggested package (vdiffr), that was used for testing
was not used conditionally.

## Test environments
* Local windows 10 install, R 4.0.3
* Travis-ci linux xenial, (r-devel, r-rel, r-oldrel)
* R-hub Windows Server 2008 R2 SP1, R-devel, 32/64 bit (r-devel)
* R-hub Fedora Linux, R-devel, clang, gfortran (r-devel)


## R CMD check results
There were 1 NOTE, 0 ERRORs and 0 WARNINGs.

The note is about maintainer e-mail that is just a reminder to 
check those fields for a new submission. 

## Downstream dependencies
I have not run R CMD check on downstream dependencies of ormPlot, as there 
are no strong reverse dependencies to be checked.
