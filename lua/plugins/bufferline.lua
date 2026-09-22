return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      -- Hiển thị chế độ: "buffers" (mặc định) giúp quản lý file đang mở dễ hơn "tabs"
      mode = "buffers",

      -- Hiển thị icon của loại file (yêu cầu nvim-web-devicons)
      show_buffer_icons = true,
      show_buffer_close_icons = false, -- Tắt icon tắt màu đỏ ở từng tab cho đỡ rối
      show_close_icon = false, -- Tắt nút đóng tổng ở góc phải

      -- Hiển thị số thứ tự trên tab để dùng tổ hợp phím nhảy nhanh (vd: Alt + số)
      numbers = "ordinal",

      -- Thay đổi ký tự phân cách giữa các tab cho thoáng (dùng thanh đứng mảnh)
      separator_style = "thin",

      -- Luôn hiển thị thanh bufferline kể cả khi chỉ có 1 file đang mở
      always_show_bufferline = true,

      -- Làm gọn đường dẫn file nếu trùng tên
      diagnostics = "nvim_lsp", -- Hiển thị lỗi LSP (Warning/Error) ngay trên tab

      -- Tùy chỉnh màu sắc để tab đang active nổi bật hơn
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
        separator_selected = {
          fg = { attribute = "bg", highlight = "Normal" },
        },
      },
    },
  },
}
