# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Remove save dialog for quit ----
formals(quit)$save <- formals(q)$save <- "no"

# Set text editor ----
options(editor="nano")

# Define function to quote wd ----
.gwd <- function(){
	final <- system2("zsh","-c pwd",stdout=TRUE)
	final <- paste0("\"",final,"\"")
	return(final)
}

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
			strsplit(x,"=")[[1]][2]
	)
	names(.colors) <- sapply(
		colorsRaw,
		function(x)
			strsplit(x,"=")[[1]][1],
		USE.NAMES=FALSE
	)
	.GlobalEnv$.colors <- .colors
}

# Define function to apply color ----
.applyColor256 <- function(x,fg=NA,bg=NA,bold=FALSE){
	useColors <- Sys.info()["sysname"]!="Windows" # Because Windows can't read the symlinks to access colorData.rds
	if(!useColors)
		return(x)
	readColorData <- function(homeVariable)
		readRDS(
			file.path(
				Sys.getenv(homeVariable),
				".shDotFileSupport/colorData.rds"
			)
		)
	cd <- tryCatch(
		readColorData("HOME"),
		error=function(x)
			readColorData("HOMEPATH"),
		warning=function(x)
			readColorData("HOMEPATH")
	)
	final <- x
	if(!is.na(fg))
		final <- crayon::make_style(cd$hex[cd$xterm==fg])(final)
	if(!is.na(bg))
		final <- crayon::make_style(cd$hex[cd$xterm==bg],bg=TRUE)(final)
	if(!is.na(bold))
		final <- crayon::bold(final)
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
			system2("env",paste("git -C",.gwd(),"rev-parse"),stdout=TRUE,stderr=FALSE)
			TRUE
		},
		warning=function(x)
			return(FALSE)
	)
	if(!isGitRepo)
		return("")
	# Set symbols
	unpushed <- intToUtf8(8593)
	unpulled <- intToUtf8(8595)
	if(nchar(unpushed)>1){
		unpushed <- "/"
		unpulled <- "\\"
	}
	diffUnstaged <- "*"
	diffStaged <- "+"
	diffDefault <- "?"
	# Get diff indicators
	checkForHushdiff <- function(homeVariable)
		return(file.exists(file.path(Sys.getenv(homeVariable),".hushdiff")))
	hushDiffs <- checkForHushdiff("HOME")
	if(!hushDiffs)
		hushDiffs <- checkForHushdiff("HOMEPATH")
	if(!hushDiffs){
		if(length(system2("git","diff --numstat",stdout=TRUE)))
			diUnstaged <- .applyColor256(diffUnstaged,.colors$colorUnstaged)
		else
			diUnstaged <- ""
		if(length(system2("git","diff --cached --numstat",stdout=TRUE)))
			diStaged <- .applyColor256(diffStaged,.colors$colorStaged)
		else
			diStaged <- ""
		diFull <- paste0(diUnstaged,diStaged)
	}else{
		diFull <- .applyColor256(diffDefault,fg=.colors$colorUnknown,bold=TRUE)
	}
	# Get branch string
	branch <- system2(
		"git",
		paste("-C",.gwd(),"branch -vv"),
		stdout=TRUE
	)
	branch <- branch[grepl("^\\*",branch)]
	branch <- stringr::str_match(branch,"\\[.+\\]")[1,1]
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
		if(!is.na(nCommits))
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
	gitString <- trimws(paste0(diFull,"_",strUnsynced))
	# Return
	return(gitString)
}

# Define function to set prompt ----
.setPrompt <- function(expr,value,succeeded,visible){
	# Reset
	crayon::reset()
	# Set prompt string
	space <- "_"
	ps1 <- paste0(
		.applyColor256("R",fg=.colors$colorMachine,bold=TRUE),
		.getGitInfo(TRUE),
		space,
		.applyColor256(">",fg=.colors$colorSep),
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
	# Get colors from colors.sh
	.getColors()
	# Call prompt function with empty parameters
	.setPrompt(NA,NA,NA,NA)
	# Register prompt function as callback (see docs)
	addTaskCallback(.setPrompt)
}
