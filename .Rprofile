# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Remove save dialog for quit ----
formals(quit)$save <- formals(q)$save <- "no"

# Set text editor ----
options(editor="nano")

# Define function to set prompt ----
.setPrompt <- function(expr,value,succeeded,visible){
	# Get function to apply color
	applyColor <- function(x,fgColor=0,bgColor){
		ansiStart <- "\033["
		ansiEnd <- "m"
		dlm <- ";"
		fgSeq <- paste0("38",dlm,"5",dlm,fgColor)
		bgSeq <- paste0("48",dlm,"5",dlm,bgColor)
		resetSeq <- 0
		opening <- paste0(ansiStart,fgSeq,dlm,bgSeq,ansiEnd)
		closing <- paste0(ansiStart,resetSeq,ansiEnd)
		final <- paste0(opening,x,closing)
		return(final)
	}
	# Read environment variables
	`$USERNAME` <- Sys.getenv("USERNAME")
	`$COMPUTERNAME` <- Sys.getenv("COMPUTERNAME")
	# Set prompt string
	#ps1 <- paste0(`$USERNAME`,"@",`$COMPUTERNAME`," ") #TEMP
	ps1 <- applyColor("Hello",bgColor=208)
	# Formally register prompt
	options(prompt=ps1)
	# Return
	return(TRUE)
}

# Define .First function that's called on startup ----
.First <- function(){
	# Get colors from colors.sh
	colorsRaw <- system2(
		"zsh",
		c("-c \"$HOMEPATH/.shDotFileSupport/colors.sh --echo\""),
		stdout=TRUE,
		invisible=FALSE
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
