-- ================================================
--   _   ____  ______  _  _______  _  ___________ 
--  | | / / / / / __ \/ |/ / ___/ / |/ / ___/ __ \
--  | |/ / /_/ / /_/ /    / (_ / /    / (_ / /_/ /
--  |___/\____/\____/_/|_/\___/ /_/|_/\___/\____/ 
-- ================================================

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.options")
require("config.keymaps")

-- Load plugins
require("plugins.coding") --- IGNORE ---
require("plugins.database") --- IGNORE ---
require("plugins.editor") --- IGNORE ---
require("plugins.formatting") --- IGNORE ---
require("plugins.lsp") --- IGNORE ---
require("plugins.system-integration") --- IGNORE ---
require("plugins.ui") --- IGNORE ---
