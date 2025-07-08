function _G.run_python_file()
	local file = vim.fn.expand("%")
	local Terminal = require("toggleterm.terminal").Terminal
	local python_term = Terminal:new({
		cmd = "python3 " .. file,
		direction = "float",
		size = 50,
		close_on_exit = false,
	})
	python_term:toggle()
end
