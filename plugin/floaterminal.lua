vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

-- Function to create or reuse a floating window
local function create_floating_window(opts)
	opts = opts or {}
	-- Window dimensions and positioning
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local buf
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
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

	local win = vim.api.nvim_open_win(buf, true, win_config)
	return { buf = buf, win = win }
end

-- Function to toggle the floating terminal
local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		-- Create a new floating window
		state.floating = create_floating_window({ buf = state.floating.buf })

		-- If the buffer is not a terminal, convert it to a terminal
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		-- Hide the floating window
		vim.api.nvim_win_hide(state.floating.win)
		state.floating.win = -1
	end
end

-- Map <leader>tt to toggle the floating terminal
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal)
