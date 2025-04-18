# Set language (just in case) ----
Sys.setenv(LANG="en_US.UTF-8")

# Set display variable (needs to be set to R to use XQuartz, and RStudio sets it to :0 anyway)
# NOTE: If you're using renv, this file won't be sourced, so you'll need to add this line to renv's .Rprofile.
Sys.setenv(DISPLAY=":0")

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

# Define function to set prompt ----
setPrompt <- function(){
	# Set prompt
	ps1 <- "R > "
	# Formally register prompt
	options(prompt=ps1)
	# Formally register continued prompt as blank spaces of same length as prompt
	options(continue=strrep(" ",nchar(ps1)))
	# Return
	return()
}

# Define .First function that's called on startup ----
.First <- function(){
	# Source only if interactive
	if(!interactive())
		return()
	# Set prompt
	setPrompt()
	# Remove prompt setting function
	rm(setPrompt,envir=.GlobalEnv)
	# Return
	return()
}

# Set linting defaults ----
if("lintr"%in%rownames(utils::installed.packages())){
	.ShadowEnv$lintClone <- lintr::lint
	.ShadowEnv$emptyF <- function(x){}
	.ShadowEnv$lintrDefaults <- lintr::linters_with_defaults(
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

# Configure styler ----
if("styler"%in%rownames(utils::installed.packages())){
	options(styler.cache_root="styler")
	styler::cache_clear(ask=FALSE)
	options(
		languageserver.formatting_style=function(options){
			styler::create_style_guide(
				indention=styler::tidyverse_style(indent_by=1L)$indention,
				style_guide_name="cadnza",
				style_guide_version="0.1.0",
				indent_character="\t"
			)
		}
	)
}

# Set browser to launch by default with Shiny ----
options(shiny.launch.browser=TRUE)
