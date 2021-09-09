#!/usr/bin/env Rscript

# Get command line arguments ----
args <- commandArgs(TRUE)

# Validate single argument ----
if(length(args)!=1)
	quit(status=1)

# Lint ----
lintr::lint(args[1])

# Exit ----
quit(status=0)
