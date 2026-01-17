--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.scrolloff = 10

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "<leader>jq", ":%!jq .<CR>", { desc = "Format json" })
vim.keymap.set("n", "<leader>tr", ":NvimTreeOpen<CR>", { desc = "Show Tree" })
vim.g.undotree_DiffCommand = "git diff"
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>kd", ":normal gg=G<CR>", { desc = "format entire file" })
vim.keymap.set("n", "<leader>be", ':<c-u>lua require("b64").encode()<cr>', { desc = "base64 encode" })
vim.keymap.set("n", "<leader>bd", ':<c-u>lua require("b64").encode()<cr>', { desc = "base64 decode" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	callback = function()
		vim.opt_local.foldmethod = "indent"
	end,
})

vim.opt.foldlevel = 6

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<leader>sc", ":Telescope colorscheme<CR>", { desc = "Telescope colorscheme" })

require("config.lazy")
local os_name = vim.loop.os_uname().sysname

if os_name == "Windows_NT" then
	vim.o.shell = "pwsh" -- Use "pwsh" for PowerShell v7
	vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end
