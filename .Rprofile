# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Remove save dialog for quit ----
formals(quit)$save <- formals(q)$save <- "no"

# Set text editor ----
options(editor="nano")
# Define function to set prompt
setPrompt <- function(expr,value,succeeded,visible){
	# Read environment variables
	`$USERNAME` <- Sys.getenv("USERNAME")
	`$COMPUTERNAME` <- Sys.getenv("COMPUTERNAME")
	# Set prompt string
	ps1 <- paste0(`$USERNAME`,"@",`$COMPUTERNAME`," ") #TEMP
	# Formally register prompt
	options(prompt=ps1)
	# Return
	return(TRUE)
}

# Define .First function that's called on startup ----
.First <- function(){
	# Get colors from colors.sh
	tColors <- system2(
		"zsh",
		c("-c \"$HOMEPATH/.shDotFileSupport/colors.sh --echo\""),
		stdout=TRUE,
		invisible=FALSE
	)
	tColors <- lapply(
		colorsRaw,
		function(x)
			strsplit(x,"=")[[1]][2]
	)
	names(tColors) <- sapply(
		colorsRaw,
		function(x)
			strsplit(x,"=")[[1]][1],
		USE.NAMES=FALSE
	)
	# Call prompt function with empty parameters
	setPrompt(NA,NA,NA,NA)
	# Register prompt function as callback (see docs)
	addTaskCallback(setPrompt)
}
