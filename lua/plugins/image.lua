return {
  {
    "3rd/image.nvim",
    dependencies = {
      -- Khai báo build luarocks tự động cho plugin này
      {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- Đảm bảo luarocks chạy trước các plugin cần nó
        opts = {
          rocks = { "magick" }, -- Cài đặt package magick thông qua luarocks
        },
      },
    },
    opts = {
      backend = "kitty", -- Hoặc "ueberzug", "sixel" tùy terminal bạn dùng
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "strict" },

      -- SỬA LỖI TRANSPARENCY: Cấu hình màu nền dự phòng tại đây
      fallback_for_transparency = {
        bg = "#1e1e2e", -- Thay bằng mã màu HEX trùng với theme Neovim của bạn
      },

      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
      },
    },
  },
}
