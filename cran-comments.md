## Resubmission
Changed package documentation file syntax

## Test environments
In addition to the local windows 10  R 4.3.1, I used the devtools::check_rhub()
and devtools devtools::check_win_release() to check the package on multiple
platforms. The list with results:

* Local windows 10 install, R-oldrel 
* Travis-ci linux focal, (r-devel, r-rel, r-oldrel) https://app.travis-ci.com/github/rix133/ormPlot
* Windows Server 2022, R-rel, https://win-builder.r-project.org/2vPrCrm8aB74/
* R-Hub Windows Server 2022, R-devel https://builder.r-hub.io/status/ormPlot_0.3.5.tar.gz-b272059b81934e78a4b0958acbc84608
* R-hub Ubuntu Linux 20.04.1 LTS, R-release, GCC https://builder.r-hub.io/status/ormPlot_0.3.5.tar.gz-d08d398a30c548f0b08f64839e95c9e9
* Fedora Linux, R-devel, clang, gfortran https://builder.r-hub.io/status/ormPlot_0.3.5.tar.gz-cfcb56b9e8264524a822de5f9c407575


## R CMD check results
There were some notes warnings or errors in some platforms. However the checks
from https://win-builder.r-project.org/ were all OK. The Travis-ci fails due to
failure to install Hmisc on oldrel and rel. (Nothing I can do there).
The Rhub Windows fails due to some tests failing because of API mismatch on
svglite (I could remove these tests). The Ubuntu 20 in R-Hub produces a note that
an example bulit more that 5 seconds. Same note comes from  R-Hub Fedora.

So if the required dependencies install there should be no errors.


## Downstream dependencies
I have not run R CMD check on downstream dependencies of ormPlot, as there 
are no strong reverse dependencies to be checked.
