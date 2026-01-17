return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"vim",
			"rust",
			"go",
			"vimdoc",
			"python",
			"json",
			"javascript",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" },
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true, disable = { "ruby" } },
	},
	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup(opts)
	end,
}
