vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}
-- Variables to store the floating window and buffer
local float_buf = nil
local win = nil

-- Function to toggle the floating window
local function create_floating_window(opts)
	opts = opts or {}
	-- Create a new buffer and floating window
	local width = math.floor(vim.o.columns * 0.8) -- 80% of screen width
	local height = math.floor(vim.o.lines * 0.8) -- 80% of screen height
	local row = math.floor((vim.o.lines - height) / 2) -- Center row
	local col = math.floor((vim.o.columns - width) / 2) -- Center column

	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win_config = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded", -- Optional: Use "single", "double", etc.
	}
	win = vim.api.nvim_open_win(buf, true, win_config)
	-- Optional: Set buffer content
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Welcome to your floating window!" })
	return { buf = buf, win = win }
end

-- vim.api.nvim_create_user_command("Floaterminal", function()
local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		print(state.floating.buf)
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- Map <leader>tt to toggle the floating window
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal)
