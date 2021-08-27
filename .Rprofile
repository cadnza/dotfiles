# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Remove save dialog for quit ----
formals(quit)$save <- formals(q)$save <- "no"

# Set text editor ----
options(editor="nano")

# Define function to get colors from colors.sh ----
.getColors <- function(){
	sourceColors <- function(homeVariable){
		final <- system2(
			"zsh",
			paste0(Sys.getenv(homeVariable),"/.shDotFileSupport/colors.sh --echo"),
			stdout=TRUE
		)
		return(final)
	}
	colorsRaw <- tryCatch(
		{
			sourceColors("HOME")
		},
		error=function(x){
			return(sourceColors("HOMEPATH"))
		},
		warning=function(x){
			return(sourceColors("HOMEPATH"))
		}
	)
	.colors <- lapply(
		colorsRaw,
		function(x)
			as.integer(strsplit(x,"=")[[1]][2])
	)
	names(.colors) <- sapply(
		colorsRaw,
		function(x)
			strsplit(x,"=")[[1]][1],
		USE.NAMES=FALSE
	)
	.GlobalEnv$.colors <- .colors
}

# Define function to set prompt ----
.setPrompt <- function(expr,value,succeeded,visible){
	# Reset
	crayon::reset()
	# Set prompt string
	space <- "_"
	ps1 <- paste0(
		quickColor::quickColor("R",fg=.colors$colorMachine,bold=TRUE),
		space,
		quickColor::quickColor(">",fg=.colors$colorSep),
		space
	)
	ps1 <- gsub("_+"," ",ps1)
	# Formally register prompt
	options(prompt=ps1)
	# Formally register continued prompt as blank spaces of same length as prompt
	options(continue=strrep(" ",nchar(ps1)))
	# Return
	return(TRUE)
}

# Define .First function that's called on startup ----
.First <- function(){
	# Source only if interactive ----
	if(!interactive())
		return()
	# Check for required packages ----
	reqd <- c(
		devtools="https://devtools.r-lib.org/",
		quickColor="https://github.com/cadnza/quickColor",
		crayon="https://www.r-project.org/nosvn/pandoc/crayon.html"
	)
	blank <- ""
	for(i in 1:length(reqd))
		if(!names(reqd)[i]%in%rownames(utils::installed.packages())){
			warning(
				paste(
					blank,
					paste("The .Rprofile from shDotFiles needs",names(reqd)[i],"to run,"),
					"so it's been disabled for this session.",
					blank,
					reqd[i],
					blank,
					sep="\n"
				),
				call.=FALSE
			)
			invisible(return())
		}
	# Get colors from colors.sh
	.getColors()
	# Call prompt function with empty parameters
	.setPrompt(NA,NA,NA,NA)
	# Register prompt function as callback (see docs)
	addTaskCallback(.setPrompt)
	# Clean up global environment
	rm(.getColors,envir=.GlobalEnv)
	rm(.setPrompt,envir=.GlobalEnv)
	rm(.First,envir=.GlobalEnv)
}
