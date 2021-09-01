# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Open environment for variables that need to be available throughout ----
.GlobalEnv$.ShadowEnv <- new.env(parent=.GlobalEnv)

# Remove save dialog for quit ----
.ShadowEnv$quitClone <- quit
.ShadowEnv$quitCustom <- function(
	save="default",
	status=0,
	runLast=TRUE
)
	.ShadowEnv$quitClone(save="no")
environment(.ShadowEnv$quitCustom) <- asNamespace("base")
utils::assignInNamespace("quit",.ShadowEnv$quitCustom,ns="base")
utils::assignInNamespace("q",.ShadowEnv$quitCustom,ns="base")

# Set text editor ----
options(editor="nano")

# Define function to get colors from colors.sh ----
getColors <- function(){
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
	colorList <- lapply(
		colorsRaw,
		function(x)
			as.integer(strsplit(x,"=")[[1]][2])
	)
	names(colorList) <- sapply(
		colorsRaw,
		function(x)
			strsplit(x,"=")[[1]][1],
		USE.NAMES=FALSE
	)
	.ShadowEnv$colorList <- colorList
}

# Define function to set prompt ----
setPrompt <- function(expr,value,succeeded,visible){
	# Reset
	crayon::reset()
	# Set prompt string
	space <- "_"
	ps1 <- paste0(
		quickColor::quickColor("R",fg=.ShadowEnv$colorList$colorMachine,bold=TRUE),
		space,
		quickColor::quickColor(">",fg=.ShadowEnv$colorList$colorSep),
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
	# Source only if interactive
	if(!interactive())
		return()
	# Check for required packages
	reqd <- c(
		quickColor="https://github.com/cadnza/quickColor",
		crayon="https://www.rdocumentation.org/packages/crayon/versions/1.4.1/topics/crayon",
		lintr="https://www.rdocumentation.org/packages/lintr/versions/1.0.3"
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
	getColors()
	# Call prompt function with empty parameters
	setPrompt(NA,NA,NA,NA)
	# Register prompt function as callback (see docs)
	addTaskCallback(setPrompt)
	# Clean up global environment
	rm(getColors,envir=.GlobalEnv)
	rm(setPrompt,envir=.GlobalEnv)
	rm(.First,envir=.GlobalEnv)
}

# Set linting defaults ----
if("lintr"%in%rownames(utils::installed.packages())){
	.ShadowEnv$lintClone <- lintr::lint
	.ShadowEnv$emptyF <- function(x){}
	.ShadowEnv$lintrDefaults <- lintr::with_defaults(
		closed_curly_linter=.ShadowEnv$emptyF,
		commas_linter=.ShadowEnv$emptyF,
		commented_code_linter=.ShadowEnv$emptyF,
		infix_spaces_linter=.ShadowEnv$emptyF,
		line_length_linter=.ShadowEnv$emptyF,
		no_tab_linter=.ShadowEnv$emptyF,
		object_name_linter=.ShadowEnv$emptyF,
		open_curly_linter=.ShadowEnv$emptyF,
		paren_brace_linter=.ShadowEnv$emptyF,
		seq_linter=.ShadowEnv$emptyF,
		spaces_left_parentheses_linter=.ShadowEnv$emptyF
	)
	.ShadowEnv$lintCustom <- function(
		filename,
		linters=NULL,
		cache=FALSE,
		...,
		parse_settings=TRUE
	){
		.ShadowEnv$lintClone(
			filename=filename,
			linters=.ShadowEnv$lintrDefaults,
			cache=FALSE,
			...,
			parse_settings=TRUE
		)
	}
	environment(.ShadowEnv$lintCustom) <- asNamespace("lintr")
	utils::assignInNamespace("lint",.ShadowEnv$lintCustom,ns="lintr")
}
