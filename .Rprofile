# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Remove save dialog for quit ----
formals(quit)$save <- formals(q)$save <- "no"

# Set text editor ----
options(editor="nano")

# Define function to apply color ----
.applyColor256 <- function(x,fg=NA,bg=NA,bold=FALSE){
	useColors <- FALSE
	if(!useColors)
		return(x)
	applyOrReset <- function(colorNum,controlCode){
		if(!is.na(colorNum))
			final <- paste0(controlCode,dlm,5,dlm,colorNum)
		else
			final <- ""
		return(final)
	}
	ansiStart <- "\033["
	ansiEnd <- "m"
	dlm <- ";"
	resetSeq <- 0
	fgSeq <- applyOrReset(fg,38)
	bgSeq <- applyOrReset(bg,48)
	if(bold)
		fgSeq <- paste0(fgSeq,dlm,1)
	if(nchar(fgSeq)&nchar(bgSeq))
		fgbgSeq <- paste0(fgSeq,dlm,bgSeq)
	else
		fgbgSeq <- paste0(fgSeq,bgSeq)
	opening <- paste0(ansiStart,fgbgSeq,ansiEnd)
	closing <- paste0(ansiStart,resetSeq,ansiEnd)
	final <- paste0(opening,x,closing)
	return(final)
}

# Define function to get git info ----
.getGitInfo <- function(include=TRUE){
	# Return if not included
	if(!include)
		return("")
	# Check for git repo
	isGitRepo <- tryCatch(
		{
			system2("git",c("-C",getwd(),"rev-parse"),stdout=TRUE,stderr=FALSE)
			TRUE
		},
		warning=function(x)
			return(FALSE)
	)
	if(!isGitRepo)
		return("")
	# Set symbols
	unpushed <- "↑"
	unpulled <- "↓"
	diff <- "*"
	diffDefault <- "?"
	# Get diff indicators
	checkForHushdiff <- function(homeVariable)
		return(file.exists(paste0(homeVariable,"/.hushdiff")))
	hushDiffs <- tryCatch(
		{
			checkForHushdiff("$HOME")
		},
		error=function(x){
			return(checkForHushdiff("$HOMEPATH"))
		},
		warning=function(x){
			return(checkForHushdiff("$HOMEPATH"))
		}
	)
	if(!hushDiffs){
		if(length(system2("git","diff --cached --numstat",stdout=TRUE)))
			diStaged <- .applyColor256(diff,.colors$colorStaged)
		else
			diStaged <- ""
		if(length(system2("git","diff --cached --numstat",stdout=TRUE)))
			diUnstaged <- .applyColor256(diff,.colors$colorUnstaged)
		else
			diUnstaged <- ""
		diFull <- paste0(diStaged,diUnstaged)
	}else{
		diFull <- .applyColor256(diffDefault,fg=.colors$colorUnknown,bold=TRUE)
	}
	# Get branch string
	branch <- system2(
		"git",
		c("-C",getwd(),"branch -vv","| grep ^\\* | grep -Eo '\\[.+\\]'"),
		stdout=TRUE
	)
	# Extract unpushed and unpulled commits
	nCommitsUnpushed <- strsplit(
		stringr::str_match(branch,"ahead \\d+")[1,1],
		" "
	)[[1]][2]
	nCommitsUnpulled <- strsplit(
		stringr::str_match(branch,"behind \\d+")[1,1],
		" "
	)[[1]][2]
	# Format unpushed and unpulled indicators
	formatNcommits <- function(nCommits,ind,colorNum){
		if(nchar(nCommits))
			final <- paste0(
				.applyColor256(paste0(ind),fg=colorNum,bold=TRUE),
				.applyColor256(paste0(nCommits),fg=colorNum)
			)
		else
			final <- ""
		return(final)
	}
	strUnpushed <- formatNcommits(nCommitsUnpushed,unpushed,.colors$colorUnpushed)
	strUnpulled <- formatNcommits(nCommitsUnpulled,unpulled,.colors$colorUnpulled)
	strUnsynced <- paste0(strUnpushed,strUnpulled)
	# Combine git string
	gitString <- trimws(paste(diFull,strUnsynced))
	# Return
	return(gitString)
}

# Define function to set prompt ----
.setPrompt <- function(expr,value,succeeded,visible){
	# Reset
	crayon::reset()
	# Set prompt string
	space <- " "
	ps1 <- paste0(
		"\n",
		.applyColor256("R",fg=.colors$colorMachine,bold=TRUE),
		.getGitInfo(TRUE),
		space,
		.applyColor256(">",fg=.colors$colorSep),
		space
	)
	# Formally register prompt
	options(prompt=ps1)
	# Return
	return(TRUE)
}

# Define .First function that's called on startup ----
.First <- function(){
	# Get colors from colors.sh
	sourceColors <- function(homeVariable){
		final <- system2(
			"zsh",
			paste0(homeVariable,"/.shDotFileSupport/colors.sh --echo"),
			stdout=TRUE
		)
		return(final)
	}
	colorsRaw <- tryCatch(
		{
			sourceColors("$HOME")
		},
		error=function(x){
			return(sourceColors("$HOMEPATH"))
		},
		warning=function(x){
			return(sourceColors("$HOMEPATH"))
		}
	)
	.colors <- lapply(
		colorsRaw,
		function(x)
			strsplit(x,"=")[[1]][2]
	)
	names(.colors) <- sapply(
		colorsRaw,
		function(x)
			strsplit(x,"=")[[1]][1],
		USE.NAMES=FALSE
	)
	.GlobalEnv$.colors <- .colors
	#setwd("/Users/cadnza/Repos/testRepo") #TEMP
	# Call prompt function with empty parameters
	.setPrompt(NA,NA,NA,NA)
	# Register prompt function as callback (see docs)
	addTaskCallback(.setPrompt)
}
