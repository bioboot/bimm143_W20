---
layout: page
title: Bioconductor setup
---

As we already noted back in [Lecture 7]({{ site.baseurl }}/lectures/#7) Bioconductor is a large repository and resource for R packages that focus on analysis of high-throughput genomic data.  

Bioconductor packages are installed differently than "regular" R packages from CRAN. To install the core Bioconductor packages ([more information here](https://www.bioconductor.org/install/)), copy and paste these lines of code into your R console **one at a time**. 

```r
install.packages("BiocManager")
BiocManager::install()

# For this class, you'll also need DESeq2:
BiocManager::install("DESeq2")
```

### Important notes on the install process
The entire install process can take some time as there are many packages with dependencies on other packages. 
- Bioconductor packages generally have way more extensive dependencies with one another (i.e. require other Bioconductor packages to operate). This is because the Bioconductor community promotes re-use of data representations and analysis concepts across packages. There is thus a higher premium on knowing that packages are from the same release, and that all packages are current within the release (hence the separate install process distinct from that of CRAN).

Your install process may produce some notes or other output. Generally, as long as you don't get an error message, you're good to go.  However:  
- If you do get a message that says something like: `Error in library(somePackageName) : there is no package called 'somePackageName'`, then the required packages did not install correctly.  
- For such error messages try installing this package separately with the command `biocLite("somePackageName")` replacing the `somePackageName` for the name of the package giving you problems. If you still get an error message let me know and we will work through it together.  


We will be using the latest versions of Bioconductor from the 3.5 release. This requires R version 3.4.0 or higher. If you have R 3.4.0 installed, running the commands above will install Bioconductor 3.5. See <http://bioconductor.org/news/bioc_3_5_release/>.
- If at any point in the Bioconductor package installations you get prompts in the console asking you to update any existing packages, type `n` at the prompt and hit enter.
- If you see a note long the lines of "_binary version available but the source version is later_", followed by a question, "_Do you want to install from sources the package which needs compilation? y/n_", type **`n` for no**, and hit enter.

### Check your install
Check that you've installed everything correctly by closing and reopening RStudio and entering the following command at the console window:

```r
library(BiocInstaller)
```

If you get a message that says something like: `Error in library(BiocInstaller) : there is no package called 'BiocInstaller'`, then the required packages did not install correctly. Please let us know so we can debug this together.  

If you get a warning message that says something like: `Warning message:
package ‘BiocInstaller’ was built under R version 3.4.2` then you likely don't have the most recent version of R installed. As long as you are at or above R version 3.4.0 you are fine for this class and there is no need to upgrade.  To see your R version you can check the initial splash scree that appears when you start R in the console window. Or type:

```r
R.version.string
```

Note there is no parenthesis in the above command. For me it returns:

```r
R.version.string
### [1] "R version 3.5.1 (2018-07-02)"
```

If you are on an old version (before 3.5.0 please) use the following for installing Bioconductor packages: 

```r
source("http://bioconductor.org/biocLite.R")
biocLite()

# For this class, you'll also need DESeq2:
biocLite("DESeq2")
```
