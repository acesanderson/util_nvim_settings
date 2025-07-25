-- lua/commands.lua
-- Custom user commands for Neovim

-- Helper function to check if current buffer is a Python file
local function is_python_file()
	return vim.bo.filetype == "python" or vim.fn.expand("%:e") == "py"
end

-- Helper function to get current file path with validation
local function get_current_python_file()
	if not is_python_file() then
		vim.notify("Current buffer is not a Python file", vim.log.levels.WARN)
		return nil
	end

	local filepath = vim.fn.expand("%:p")
	if filepath == "" then
		vim.notify("No file associated with current buffer", vim.log.levels.WARN)
		return nil
	end

	return filepath
end

-- Helper function to find project root directory
local function find_project_root(filepath)
	local current_dir = vim.fn.fnamemodify(filepath, ":h")

	-- Common project root indicators (in order of preference)
	local root_indicators = {
		"pyproject.toml",
		"setup.py",
		"requirements.txt",
		"Pipfile",
		".git",
		".gitignore",
		"README.md",
		"README.rst",
		".venv",
		"venv",
	}

	-- Walk up the directory tree
	while current_dir ~= "/" and current_dir ~= "." do
		for _, indicator in ipairs(root_indicators) do
			local indicator_path = current_dir .. "/" .. indicator
			if vim.fn.filereadable(indicator_path) == 1 or vim.fn.isdirectory(indicator_path) == 1 then
				return current_dir
			end
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end

	-- Fallback: use the directory containing the file
	return vim.fn.fnamemodify(filepath, ":h")
end

-- Generate docstring for current line context (file, function, or class)
vim.api.nvim_create_user_command("DocsGenerate", function(opts)
	local filepath = get_current_python_file()
	if not filepath then
		return
	end

	-- Get current line number
	local line_number = vim.fn.line(".")

	-- Get project root (can be overridden with argument)
	local project_root
	if opts.args and opts.args ~= "" then
		project_root = vim.fn.expand(opts.args)
		if vim.fn.isdirectory(project_root) ~= 1 then
			vim.notify("Specified directory does not exist: " .. project_root, vim.log.levels.ERROR)
			return
		end
	else
		project_root = find_project_root(filepath)
	end

	-- Save buffer if modified
	if vim.bo.modified then
		vim.cmd("write")
	end

	-- Execute the docs command with file, project root, and line number
	vim.notify(
		"Generating docstring at line " .. line_number .. " (root: " .. project_root .. ")...",
		vim.log.levels.INFO
	)

	local cmd = "docs "
		.. vim.fn.shellescape(filepath)
		.. " "
		.. vim.fn.shellescape(project_root)
		.. " --line "
		.. line_number
	local result = vim.fn.system(cmd)

	-- Check for errors
	if vim.v.shell_error ~= 0 then
		vim.notify("Error generating docstring: " .. result, vim.log.levels.ERROR)
		return
	end

	-- Reload buffer to show changes
	vim.cmd("edit!")
	vim.notify("Docstring generated successfully!", vim.log.levels.INFO)
end, {
	desc = "Generate docstring for current line context (file/function/class)",
	nargs = "?", -- Optional argument for custom project root
	complete = "dir", -- Tab completion for directories
})

-- Async version
vim.api.nvim_create_user_command("DocsGenerateAsync", function(opts)
	local filepath = get_current_python_file()
	if not filepath then
		return
	end

	-- Get current line number
	local line_number = vim.fn.line(".")

	-- Get project root (can be overridden with argument)
	local project_root
	if opts.args and opts.args ~= "" then
		project_root = vim.fn.expand(opts.args)
		if vim.fn.isdirectory(project_root) ~= 1 then
			vim.notify("Specified directory does not exist: " .. project_root, vim.log.levels.ERROR)
			return
		end
	else
		project_root = find_project_root(filepath)
	end

	-- Save buffer if modified
	if vim.bo.modified then
		vim.cmd("write")
	end

	vim.notify(
		"Generating docstring at line " .. line_number .. " (root: " .. project_root .. ")...",
		vim.log.levels.INFO
	)

	-- Use jobstart for async execution
	vim.fn.jobstart({ "docs", filepath, project_root, "--line", tostring(line_number) }, {
		on_exit = function(_, exit_code)
			if exit_code ~= 0 then
				vim.notify("Error generating docstring", vim.log.levels.ERROR)
			else
				vim.cmd("edit!")
				vim.notify("Docstring generated successfully!", vim.log.levels.INFO)
			end
		end,
		on_stderr = function(_, data)
			if data and #data > 0 then
				local error_msg = table.concat(data, "\n")
				if error_msg:match("%S") then -- Check if not just whitespace
					vim.notify("Docs error: " .. error_msg, vim.log.levels.ERROR)
				end
			end
		end,
	})
end, {
	desc = "Generate docstring for current line context (async)",
	nargs = "?", -- Optional argument for custom project root
	complete = "dir", -- Tab completion for directories
})

-- Command to show detected project root and current line (useful for debugging)
vim.api.nvim_create_user_command("DocsShowContext", function()
	local filepath = get_current_python_file()
	if not filepath then
		return
	end

	local project_root = find_project_root(filepath)
	local line_number = vim.fn.line(".")

	vim.notify("File: " .. filepath, vim.log.levels.INFO)
	vim.notify("Project root: " .. project_root, vim.log.levels.INFO)
	vim.notify("Current line: " .. line_number, vim.log.levels.INFO)
end, {
	desc = "Show context info for docstring generation",
})

-- Optional: Create a shorter alias
vim.api.nvim_create_user_command("Docs", function(opts)
	vim.cmd("DocsGenerate " .. (opts.args or ""))
end, {
	desc = "Alias for DocsGenerate",
	nargs = "?",
	complete = "dir",
})
