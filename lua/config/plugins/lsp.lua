return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").vuels.setup({})
		end,
	},
}
