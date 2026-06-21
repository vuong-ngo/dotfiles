-- ================================================
--   _   ____  ______  _  _______  _  ___________
--  | | / / / / / __ \/ |/ / ___/ / |/ / ___/ __ \
--  | |/ / /_/ / /_/ /    / (_ / /    / (_ / /_/ /
--  |___/\____/\____/_/|_/\___/ /_/|_/\___/\____/
-- ================================================

return {
	-- Setup autocompletion
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
				-- Trigger completion with Tab (only when there are suggestions)
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
			})
		end,
	},

	-- Auto-close brackets, quotes, etc. with smart behavior in Insert mode
	{
		"nvim-mini/mini.pairs",
		event = "InsertEnter", -- Just download
		opts = {
			modes = { insert = true, command = false, terminal = false },
		},
	},

	-- Improve file icons with a modern, consistent set of icons that integrate well with the rest of the UI
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {
			preset = "nerd", -- Sử dụng bộ icon Nerd Font để có nhiều biểu tượng hơn
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- Set up nvim-treesitter for enhanced syntax highlighting, indentation, and folding
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"caddy",
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
		},
	},

	-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
	-- would overwrite `ensure_installed` with the new value.
	-- If you'd rather extend the default config, use the code below instead:
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"tsx",
				"typescript",
			})
		end,
	},

	-- version mason
	{ "mason-org/mason.nvim", version = "1.11.0" },
	{ "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
	-- 2. Install Mason LSP servers và formatters cho Python và Bash
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"pyright", -- LSP for Python
				"gdscript", -- LSP for GDScript
				"bash-language-server", -- LSP for Bash
				"black", -- Formatter for Python
				"isort", -- Import sorter for Python
				"shfmt", -- Formatter for Bash
			})
		end,
	},

	{
		"mason-org/mason.nvim",
		-- version = "v1.11.0",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			-- manually install packages that do not exist in this list please
			ensure_installed = { "zls", "gopls", "ts_ls" },
		},
	},
}
