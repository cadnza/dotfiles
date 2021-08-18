# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Remove save dialog for quit ----
formals(quit)$save <- formals(q)$save <- "no"

# Set text editor ----
options(editor="nano")

# Define function to set prompt ----
.setPrompt <- function(expr,value,succeeded,visible){
	# Get function to apply color
	applyColor256 <- function(x,fg=NA,bg=NA,bold=FALSE){
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
	# Reset
	crayon::reset()
	# Set prompt string
	space <- " "
	ps1 <- paste0(
		applyColor256("R",fg=.colors$colorMachine,bold=TRUE),
		space,
		applyColor256(">",fg=.colors$colorSep),
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
			paste0("-c \"",homeVariable,"/.shDotFileSupport/colors.sh --echo\""),
			stdout=TRUE,
			invisible=FALSE
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
	# Call prompt function with empty parameters
	.setPrompt(NA,NA,NA,NA)
	# Register prompt function as callback (see docs)
	addTaskCallback(.setPrompt)
}
