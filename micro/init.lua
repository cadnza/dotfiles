function init()
	linter.makeLinter(
		"lintr",
		"r",
		"lintr_r.R",
		{"%f"},
		"%f:%l:%c: %m",
		{},
		false,
		false,
		0,
		0
	)
	linter.makeLinter(
		"pylint",
		"python",
		"pylint_python.sh",
		{"%f"},
		"%f:%l:%c: %m",
		{},
		false,
		false,
		0,
		0
	)
    linter.makeLinter(
		"sqlfluff",
		"sql",
		"sqlfluff_sql.sh",
		{"%f"},
		"%f:%l:%c: %m",
		{},
		false,
		false,
		0,
		0
	)
	linter.makeLinter(
		"swiftlint",
		"swift",
		"swiftlint",
		{"%f"},
		"%f:%l:%c: %m",
		{},
		false,
		false,
		0,
		0
	)
end
