vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy --primary",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste --no-newline --primary",
    ["*"] = "wl-paste --no-newline",
  },
  cache_enabled = 1,
}
