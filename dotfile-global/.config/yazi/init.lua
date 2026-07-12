-- ~/.config/yazi/init.lua

require("yatline-created-time"):setup()

function Linemode:size_and_mtime()
    local time = math.floor(self._file.cha.mtime or 0)
    if time == 0 then
        time = ""
    elseif os.date("%Y", time) == os.date("%Y") then
        time = os.date("%b %d %H:%M", time)
    else
        time = os.date("%b %d  %Y", time)
    end

    local size = self._file:size()
    return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

require("full-border"):setup({
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.ROUNDED,
})

require("smart-enter"):setup({
    open_multi = true,
})

-- lin-decompress: keymap.toml already had a keybind ("E") calling
-- `plugin lin-decompress`, but the plugin itself was never actually
-- installed, so pressing E errored with "plugin not found". Added the
-- plugin (plugins/lin-decompress.yazi) and its required setup below
-- (defaults straight from the plugin's own INIT.md).
require("lin-decompress"):setup({
    global_tar_compressor = {
        cmd = { "-dkc" },
    },
    tar_compressors = {
        ["lz4"] = { tool_name = "lz4", exts = { lz4 = true } },
        ["xz"] = { tool_name = "xz", cmd = { "-T0" }, exts = { xz = true } },
        ["gzip"] = { tool_name = "gzip", exts = { gz = true } },
        ["compress"] = { tool_name = "uncompress", exts = { Z = true } },
        ["bzip2"] = { tool_name = "bzip2", exts = { bz2 = true } },
        ["zstd"] = { tool_name = "zstd", cmd = { "-T0" }, exts = { zst = true } },
        ["lzop"] = { tool_name = "lzop", exts = { lzo = true } },
        ["lzip"] = { tool_name = "lzip", exts = { lz = true } },
        ["lzma"] = { tool_name = "lzma", exts = { lzma = true } },
    },
    other_compressors = {
        ["rar"] = {
            tool_name = "unrar",
            cmd = { "x" },
            out_cmd = "-op",
            pw_cmd = "-p",
            exts = { rar = true },
        },
        ["default"] = {
            tool_name = "7z",
            cmd = { "x", "-mmt=0" },
            out_cmd = "-o",
            pw_cmd = "-p",
        },
    },
})

-- #############################################################
local tokyo_night_theme = require("yatline-tokyo-night"):setup("night") -- or moon/storm/day

require("yatline"):setup({
    theme = tokyo_night_theme,
    
    -- Default
    section_separator = { open = "", close = "" },
    part_separator = { open = "", close = "" },
    inverse_separator = { open = "", close = "" },   

    permissions_t_fg = "green",
    permissions_r_fg = "yellow",
    permissions_w_fg = "red",
    permissions_x_fg = "cyan",
    permissions_s_fg = "white",

    tab_width = 20,
    tab_use_inverse = false,

    selected = { icon = "󰻭", fg = "yellow" },
    copied = { icon = "", fg = "green" },
    cut = { icon = "", fg = "red" },

    total = { icon = "󰮍", fg = "yellow" },
    succ = { icon = "", fg = "green" },
    fail = { icon = "", fg = "red" },
    found = { icon = "󰮕", fg = "blue" },
    processed = { icon = "󰐍", fg = "green" },

    show_background = true,

    display_header_line = true,
    display_status_line = true,

    component_positions = { "header", "tab", "status" },

    header_line = {
        left = {
            section_a = {
                { type = "line", custom = false, name = "tabs", params = { "left" } },
            },
            section_b = {},
            section_c = {},
        },
        right = {
            section_a = {},
            section_b = {},
            -- yatline-created-time was being setup() above but was never
            -- added to any line, so it displayed nothing. Wiring it in
            -- here (registers "created_time" as a Yatline coloreds
            -- component; see plugins/yatline-created-time.yazi).
            section_c = {
                { type = "coloreds", custom = false, name = "created_time" },
            },
        },
    },

    status_line = {
        left = {
            section_a = {
                { type = "string", custom = false, name = "tab_mode" },
            },
            section_b = {
                { type = "string", custom = false, name = "hovered_size" },
            },
            section_c = {
                { type = "string", custom = false, name = "hovered_path" },
                { type = "coloreds", custom = false, name = "count" },
            },
        },
        right = {
            section_a = {
                { type = "string", custom = false, name = "cursor_position" },
            },
            section_b = {
                { type = "string", custom = false, name = "cursor_percentage" },
            },
            section_c = {
                { type = "string", custom = false, name = "hovered_file_extension", params = { true } },
                { type = "coloreds", custom = false, name = "permissions" },
            },
        },
    },
})
