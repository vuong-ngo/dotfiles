-- ================================================
--   _   ____  ______  _  _______  _  ___________ 
--  | | / / / / / __ \/ |/ / ___/ / |/ / ___/ __ \
--  | |/ / /_/ / /_/ /    / (_ / /    / (_ / /_/ /
--  |___/\____/\____/_/|_/\___/ /_/|_/\___/\____/ 
-- ================================================

return {
  {
    "AstroNvim/astrocore",
    optional = true,
    opts = function()
      -- Sync clipboard between OS and Neovim.
      vim.opt.clipboard = "unnamedplus"
      if vim.fn.executable("wl-copy") == 1 then
        vim.g.clipboard = {
          name = "wl-clipboard",
          copy = {
            ["+"] = "wl-copy",
            ["*"] = "wl-copy",
          },
          paste = {
            ["+"] = "wl-paste",
            ["*"] = "wl-paste",
          },
          cache_enabled = 1,
        }
      end
    end,
  },
}