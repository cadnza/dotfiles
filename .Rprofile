# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Remove save dialog for quit ----
formals(quit)$save <- formals(q)$save <- "no"

# Set text editor ----
options(editor="nano")
# Define function to set prompt
setPrompt <- function(expr,value,succeeded,visible){
	# Set prompt string
	ps1 <- paste(value," ") #TEMP
	# Formally register prompt
	options(prompt=ps1)
	# Return
	return(TRUE)
}

# Define .First function that's called on startup ----
.First <- function(){
	# Call prompt function with empty parameters
	setPrompt(NA,NA,NA,NA)
	# Set prompt function to run every time
	addTaskCallback(setPrompt)
}
