# Set language (just in case) ----
#Sys.setenv(LANG="en")

# Open environment for variables that need to be available throughout ----
.GlobalEnv$.ShadowEnv <- new.env(parent=.GlobalEnv)

# Remove save dialog for quit ----
try(
	{
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
	},
	silent=TRUE
)

# Set text editor ----
options(editor="nano")

# Define function to get colors from shell environment ----
getColors <- function(){
	envVars <- Sys.getenv(names=TRUE)
	colorList <- lapply(as.list(envVars[grepl("^color",names(envVars))]),as.integer)
	.ShadowEnv$colorList <- colorList
}

# Define function to try to get a color from the list and return NA otherwise ----
.ShadowEnv$tryColor <- function(name){
	clr <- .ShadowEnv$colorList[[name]]
	if(is.null(clr))
		return(NA)
	return(clr)
}

# Define function to set prompt ----
setPrompt <- function(expr,value,succeeded,visible){
	# Reset
	crayon::reset()
	# Set prompt string
	space <- "_"
	ps1 <- paste0(
		quickColor::quickColor("R",fg=.ShadowEnv$tryColor("colorMachine"),bold=TRUE),
		space,
		quickColor::quickColor(">",fg=.ShadowEnv$tryColor("colorSep")),
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
	)
		.ShadowEnv$lintClone(
			filename=filename,
			linters=.ShadowEnv$lintrDefaults,
			cache=FALSE,
			...,
			parse_settings=TRUE
		)
	environment(.ShadowEnv$lintCustom) <- asNamespace("lintr")
	utils::assignInNamespace("lint",.ShadowEnv$lintCustom,ns="lintr")
}

# Set browser to launch by default with Shiny ----
options(shiny.launch.browser=TRUE)
