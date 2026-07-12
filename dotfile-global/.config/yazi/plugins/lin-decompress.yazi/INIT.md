```lua
  require("lin-decompress"):setup({
 -- Global commands for all .tar.* archives (e.g. .tar.lz, .tar.lzo, .tar.gz)
 global_tar_compressor = {
  -- Commands for each .tar.* archive,
  -- Appends these 'cmd's only if 'no_global_tar = false' is set for a .tar.* configuration below
  cmd = { "-dkc" },
 },

 -- NOTE: Use the '[name of mimetype]' portion when defining new extractors'
 --
 -- Schema:
 -- ["application/[<name of mimetype>]"] ={
 --  tool_name = "Name of tool to use for this mimetype",
 --  cmd = { list of arguments to use},
 --  no_global_tar = true (default: false) (Appends the commands specified in the 'global_tar_compressor.cmd')
 --  exts = {extension_name = true, ...} (Extension names of the archive to extract. Used only as a fallback in case mime detection fails)
 -- }
 -- Configurations for compressors commonly used with .tar.*
 tar_compressors = {
  ["lz4"] = {
   tool_name = "lz4",
   exts = {
    lz4 = true,
   },
  },
  ["xz"] = {
   tool_name = "xz",
   cmd = { "-T0" },
   exts = {
    xz = true,
   },
  },
  ["gzip"] = {
   tool_name = "gzip",
   exts = {
    gz = true,
   },
  },
  ["compress"] = {
   tool_name = "uncompress",
   exts = {
    Z = true,
   },
  },
  ["bzip2"] = {
   tool_name = "bzip2",
   exts = {
    bz2 = true,
   },
  },
  ["zstd"] = {
   tool_name = "zstd",
   cmd = { "-T0" },
   exts = {
    zst = true,
   },
  },
  ["lzop"] = {
   tool_name = "lzop",
   exts = {
    lzo = true,
   },
  },
  ["lzip"] = {
   tool_name = "lzip",
   exts = {
    lz = true,
   },
  },
  ["lzma"] = {
   tool_name = "lzma",
   exts = {
    lzma = true,
   },
  },
 },
 -- NOTE: Use the '[name of mimetype]' portion when defining new extractors'
 --
 -- Schema:
 -- ["application/[name of mimetype]"] ={
 --  tool_name = "Name of tool to use",
 --  cmd = {list of arguments to use },
 --  out_cmd = "The command to output extracted content",
 --  pw_cmd = "Command to input a Password"
 --  exts = {extension_name = true, ...} (Extension names of the archive to extract. Used only as a fallback in case mime detection fails)
 -- }
 -- Configurations for non .tar archives
 other_compressors = {
  ["rar"] = {
   tool_name = "unrar",
   cmd = { "x" },
   out_cmd = "-op",
   pw_cmd = "-p",
   exts = {
    rar = true,
   },
  },
  -- The default tool to use to extract ALL types of archive files
  ["default"] = {
   tool_name = "7z",
   cmd = { "x", "-mmt=0" },
   out_cmd = "-o",
   pw_cmd = "-p",
  },
 },
})
```
