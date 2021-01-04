## Resubmission
Can now plot lrm models similary to orm

## Test environments
* Local windows 10 install, R 4.0.3
* Travis-ci linux xenial, (r-devel, r-rel, r-oldrel)
* R-hub Windows Server 2008 R2 SP1, R-devel, 32/64 bit (r-devel)
* R-hub Fedora Linux, R-devel, clang, gfortran (r-devel)
* Ubuntu Linux 16.04 LTS, R-release, GCC (r-rel)


## R CMD check results
There were 0 NOTE, 0 ERRORs and 0 WARNINGs. on most platforms. However,
On R-hub Fedora Linux, R-devel, clang, gfortran (r-devel) 
There was one NOTE: Examples with CPU (user + system) or elapsed time > 5s
On Ubuntu Linux 16.04 LTS, R-release, GCC (r-rel)
ERROR: can't install suggested package 'vdiffr'
However, this issue does not appear if variable _R_CHECK_FORCE_SUGGESTS_ is set
to false. Hence, I belive there is nothing else I can to if I want to keep the
tests.


## Downstream dependencies
I have not run R CMD check on downstream dependencies of ormPlot, as there 
are no strong reverse dependencies to be checked.
