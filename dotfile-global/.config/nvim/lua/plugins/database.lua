-- ================================================
--   _   ____  ______  _  _______  _  ___________ 
--  | | / / / / / __ \/ |/ / ___/ / |/ / ___/ __ \
--  | |/ / /_/ / /_/ /    / (_ / /    / (_ / /_/ /
--  |___/\____/\____/_/|_/\___/ /_/|_/\___/\____/ 
-- ================================================

return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Sử dụng icon đẹp từ Nerd Font
			vim.g.db_ui_use_nerd_fonts = 1

			-- Đường dẫn lưu trữ các file cấu hình kết nối an toàn
			vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"

			-- Tùy chỉnh hiển thị
			vim.g.db_ui_win_position = "right" -- Hiển thị cây thư mục DB bên phải
		end,
	},
}
