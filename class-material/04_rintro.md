---
layout: page
title: R Language Basics (Part 1)
---

**BIMM-143 Lecture 4:**   
Barry Grant &lt; <http://thegrantlab.org> &gt;
{:.message}

### 1. Background

R is powerful data programming language that you can use to explore and understand data in an open-ended, highly interactive, iterative way. Learning R will give you the freedom to experiment and problem solve during data analysis — exactly what we need as bioinformaticians.

Before delving into working with real data in R, we need to learn the basics of the R language. In this section, we’ll learn how to do simple calculations in R, assign values to variables, and call functions. Then, we’ll look at R’s vectors, vector data types, and vectorization. This is not the most exciting thing in the world but it is important because vectors and vectorization underpin how we approach many problems in R.

### 2. Simple Calculations

Open RStudio, or a terminal R prompt, and try typing the basic arithmetic below. If you are using RStudio we will be typing directly into the *Console* that contains the live R process.

``` r
5+3
```

    ## [1] 8

``` r
5-3
```

    ## [1] 2

``` r
5*3
```

    ## [1] 15

``` r
5/3
```

    ## [1] 1.666667


### 3. Saving your answers - object assignment

Lets make an assignment and then inspect the object you just created.

``` r
x <- 3 * 4  
x
```

    ## [1] 12

All R statements where you create objects -- "assignments" -- have this form:

``` r
objectName <- value  
```

and in my head I hear: objectName gets value, e.g.,  "x gets 12".

You will make lots of assignments and the operator `<-` is a pain to type. Don't be lazy and use `=`, although it would work, because it will just sow confusion later. Instead, utilize RStudio's keyboard shortcut: On a PC `Alt + -` (that is push the Alt button with the minus sign button); On a Mac it is Option + - (that is push the Option button with the minus sign button).

Notice that RStudio automagically surrounds `<-` with spaces, which demonstrates a useful code formatting practice. Code is miserable to read on a good day. Give your eyes a break and use spaces.

RStudio offers many handy [keyboard shortcuts](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts). Also, Alt+Shift+K brings up a keyboard shortcut reference card. Check them out!

#### A note about object names

Object names cannot start with a digit and cannot contain certain other characters such as a comma or a space. You will be wise to adopt a [convention for demarcating words](http://en.wikipedia.org/wiki/Snake_case) in names.

``` r
i_use_snake_case  
other.people.use.periods  
evenOthersUseCamelCase  
```

Make another assignment

``` r
this_is_a_really_long_name <- 2.5  
```

To inspect this, try out RStudio's completion facility: type the first few characters, press `TAB`, add characters until you disambiguate, then press return.

Make another assignment

``` r
r_rocks <- 2 ^ 3  
```

Let's try to inspect:

``` r
rrocks
```

    ## Error in eval(expr, envir, enclos): object 'rrocks' not found

What happened? What about this one?

``` r
R_rocks
```

> **Conclusion:** When we program we enter into an implicit contract with the computer. The computer will do tedious computation for you. In return, you will be completely precise in your instructions. Typos matter. Case matters. **Therefore get better at typing!**

### 4. Calling Functions

R has a mind-blowing collection of built-in functions that are accessed like so:

``` r
functionName(arg1 = val1, arg2 = val2, and so on)
```

Let's try using the `seq()` function, which makes regular sequences of numbers and, while we're at it, demo more helpful features of RStudio.

Type `se` and hit TAB. A pop up shows you possible completions. Specify `seq()` by typing more to disambiguate or using the up/down arrows to select.

Notice the floating tool-tip-type help that pops up, reminding you of a function's arguments. If you want even more help, press F1 as directed to get the full documentation in the help tab of the lower right pane. Now open the parentheses and notice the automatic addition of the closing parenthesis and the placement of cursor in the middle. Type the arguments `1, 10` and hit return. RStudio also exits the parenthetical expression for you. IDEs are helpful when starting out!

``` r
seq(1,10)  
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

You can always access the help/documentation of a particular function by using the `help(myFunction)` function, e.g. `help(seq)`.

The previous `seq()` example above also demonstrates something about how R resolves function arguments. You can always specify in `name = value` form. But if you do not, R attempts to resolve by position. So above, it is assumed that we want a sequence `from = 1` that goes `to = 1`. Since we didn't specify step size, the default value of `by` in the function definition is used, which ends up being 1 in this case. For functions I call often, I might use this resolve by position for the first argument or maybe the first two. After that, I always use `name = value`.

What does the following command do?

``` r
seq(1,10, by=2)  
```

    ## [1] 1 3 5 7 9

Could you of figured this out from the documentation accessed via the command `?seq` or `help(seq)`?  

One very useful part of a functions documentation is the **Examples** section (typically found at the very end of the documentation entry).

You can copy and paste these into your session or execute them all in one go with the `examples()` function, e.g.

``` r
example(seq)
```

Not all functions have (or require) arguments, e.g.:

``` r
date()
```

    ## [1] "Tue Oct 17 15:50:04 2017"

### 5. Getting help in R

As would be expected from a sophisticated scientific and statistical computing language, R has oodles of functions—far more than any reasonable human can expect to learn and remember. Consequently, you’ll need to master two of the most practical R skills:

-   Knowing how to look up a function’s documentation to recall its arguments and how it works.

-   Being able to discover new useful functions.

Each of R’s functions (and other objects such as constants like pi, classes, and packages) has integrated documentation accessible within R. R’s documentation includes descriptions and details about the function, all arguments of a function, and useful usage examples. You access R’s built-in documentation with the `help()` function or its syntactic shortcut, `?`:

``` r
help(log)
?log
```

In RStudio, this opens a special help window containing log()’s documentation. In terminal R, this documentation is handled by your default pager (probably the program less). Operators such as + and ^ need to be quoted (e.g., help('+')).

R’s `help()` function is useful when you already know the name of the function you need documentation for. Unfortunately, we often only have a fuzzier idea of what we need help with (e.g., what was the function in R that calculates cross tabulate vectors?). For tasks like this, we can search R’s help system with the function `help.search()`, or its shortcut `??`:

``` r
help.search("cross tabulate")
??"cross tabulate"
```

In this case, `help.search()` would help you find the function `table()`, which is useful in creating counts and cross tabulations from vectors.

Also, R has the neat feature that all examples in an R help file can be executed with the function `example()`. For example:

``` r
example(log)
```

    ## 
    ## log> log(exp(3))
    ## [1] 3
    ## 
    ## log> log10(1e7) # = 7
    ## [1] 7
    ## 
    ## log> x <- 10^-(1+2*1:9)
    ## 
    ## log> cbind(x, log(1+x), log1p(x), exp(x)-1, expm1(x))
    ##           x                                                    
    ##  [1,] 1e-03 9.995003e-04 9.995003e-04 1.000500e-03 1.000500e-03
    ##  [2,] 1e-05 9.999950e-06 9.999950e-06 1.000005e-05 1.000005e-05
    ##  [3,] 1e-07 1.000000e-07 1.000000e-07 1.000000e-07 1.000000e-07
    ##  [4,] 1e-09 1.000000e-09 1.000000e-09 1.000000e-09 1.000000e-09
    ##  [5,] 1e-11 1.000000e-11 1.000000e-11 1.000000e-11 1.000000e-11
    ##  [6,] 1e-13 9.992007e-14 1.000000e-13 9.992007e-14 1.000000e-13
    ##  [7,] 1e-15 1.110223e-15 1.000000e-15 1.110223e-15 1.000000e-15
    ##  [8,] 1e-17 0.000000e+00 1.000000e-17 0.000000e+00 1.000000e-17
    ##  [9,] 1e-19 0.000000e+00 1.000000e-19 0.000000e+00 1.000000e-19

R also has functions for listing all functions in a package (e.g., `library(help="base")`) and finding functions by name (e.g., `apropos("norm")`), which are often useful in remembering a function’s name.

Later today we will cover a special form of package documentation called **vignettes**. These are basically short task oriented introductions and tutorials for a particular set of related functions.

### 6. Vectors, Vectorization, and Indexing

Arguably the most important feature of the R language is its vectors. A vector is a container of contiguous data. Unlike most languages, R does not have a type for a single value (known as a scalar) such as 3.1 or “AGCTACGACT.” Rather, these values are stored in a vector of length 1. We can verify that values like 3.1 are vectors of length 1 by calling the function length() (which returns the length of a vector) on them:

``` r
length(3.1) 
```

    ## [1] 1

To create longer vectors, we combine values with the function c():

``` r
x <- c(56, 95.3, 0.4)
x
```

    ## [1] 56.0 95.3  0.4

``` r
y <- c(3.2, 1.1, 0.2)
y
```

    ## [1] 3.2 1.1 0.2

#### Vectorization

R’s vectors are the basis of one of R’s most important features: **vectorization**. Vectorization allows us to loop over vectors elementwise, without the need to write an explicit loop. For example, R’s arithmetic operators are all vectorized:

``` r
x+y
```

    ## [1] 59.2 96.4  0.6

``` r
x-y
```

    ## [1] 52.8 94.2  0.2

``` r
x/y
```

    ## [1] 17.50000 86.63636  2.00000

In addition to operators like `+` and `*`, many of R’s math functions (e.g., `sqrt()`, `round()`, `log()`, etc.) are all vectorized:

``` r
sqrt(x)
```

    ## [1] 7.4833148 9.7621719 0.6324555

``` r
round(sqrt(x), 3)
```

    ## [1] 7.483 9.762 0.632

``` r
log(x)/2 + 1 # note how we can combined vectorized operations
```

    ## [1] 3.0126758 3.2785149 0.5418546

This vectorized approach is not only more clear and readable, it’s also often computationally faster.

> **Concludion:** Unlike other languages, R allows us to completely forgo explicitly looping over vectors with a for loop. Later on, we’ll see other methods used for more explicit looping.

#### Vector Indexing (or getting to your data subset)

We can access specific elements of a vector through indexing. An index is an integer that specifies which element in the vector to retrieve. We can use indexing to get or set values to certain elements from a vector:

``` r
x <- c(56, 95.3, 0.4)
x[2]
```

    ## [1] 95.3

R’s vectors are 1-indexed, meaning that the index 1 corresponds to the first ele‐ ment in a list (in contrast to 0-indexed languages like Python). Here, the value 95.3 is the 2nd item, and is accessed with x\[2\].

``` r
x[1]
```

    ## [1] 56

``` r
x[4]
```

    ## [1] NA

Trying to access an element that doesn’t exist in the vector leads R to return NA, the “not available” missing value.

``` r
x[3] <- 0.5
x
```

    ## [1] 56.0 95.3  0.5

We can change specific vector elements by combining indexing and assignment.

Our next session will cover more on **vectors**, and the other major R data structures (**matrices**, **data.frames** and **lists**).

### 7. A note about RStudio projects

Keeping all the files associated with a project organized together -- input data, R scripts, analytical results, figures -- is such a wise and common practice that RStudio has built-in support for this via its *projects*.

[Using Projects](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects)

Let's make one to use for the rest of this class. Do this: File &gt; New Project .... The directory name you choose here will be the project name. Call it whatever you want (or follow me for convenience *Desktop/bootcamp/R/session1*).

### 8. Miscellaneous points

It is traditional to save R scripts with a `.R` or `.r` suffix. Follow this convention unless you have some extraordinary reason not to.

Comments start with one or more `#` symbols. Use them. RStudio helps you (de)comment selected lines with Ctrl+Shift+C (windows and linux) or Command+Shift+C (mac).

Clean out the workspace, ie pretend like you've just revisited this project after a long absence. The broom icon or `rm(list = ls())`. Good idea to do this, restart R (available from the Session menu), re-run your analysis to truly check that the code you're saving is complete and correct (or at least rule out obvious problems!).

This work-flow will serve you well in the future:

-   Create an RStudio project for an analytical project
-   Keep inputs there (we'll soon talk about importing)
-   Keep scripts there; edit them, run them in bits or as a whole from there
-   Keep outputs there (like the PDF written above)

> Avoid using the mouse for pieces of your analytical work-flow, such as loading a dataset or saving a figure. Terribly important for reproducibility and for making it possible to retrospectively determine how a numerical table or PDF was actually produced (searching on local disk on filename, among `.R` files, will lead to the relevant script).

Many long-time users never save the workspace, never save `.RData` files (I'm one of them), never save or consult the history. Once/if you get to that point, there are options available in RStudio to disable the loading of .RData and permanently suppress the prompt on exit to save the workspace (go to Tools-&gt;Options-&gt;General).

For the record, when loading data into R and/or writing outputs to file, you can always specify the absolute path and thereby insulate yourself from the current working directory. This is rarely necessary when using RStudio Projects properly

### 9. Reproducibility and sessionInfo()

Versions of R and any R packages installed change over time. This can lead to reproducibility headaches, as the results of your analyses may change with the changing version of R and R packages. Solving these issues is an area of ongoing development (see, for example, the packrat package). At the very least, you should always record the versions of R and any packages you use for an analysis. R actually makes this incredibly easy to do—just call the `sessionInfo()` function:

``` r
sessionInfo()
```

    ## R version 3.4.1 (2017-06-30))
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS Sierra 10.12.6
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] magrittr_1.5       formatR_1.2.1      tools_3.2.3       
    ##  [4] htmltools_0.3.5    yaml_2.1.13        Rcpp_0.12.4       
    ##  [7] stringi_1.0-1      rmarkdown_1.0.9002 knitr_1.13        
    ## [10] stringr_1.0.0      digest_0.6.9       evaluate_0.9