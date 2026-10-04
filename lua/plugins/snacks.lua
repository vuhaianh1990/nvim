-- Kiểm tra xem hệ điều hành hiện tại có phải là macOS hay không
local is_mac = vim.uv.os_uname().sysname == "Darwin"

return {
  {
    "folke/snacks.nvim",
    -- Nếu không phải macOS, giữ nguyên mặc định của LazyVim
    opts = {
      picker = {
        -- Cấu hình hiển thị file ẩn và file nhạy cảm
        sources = {
          files = {
            hidden = true,
            -- ignored = true,
            follow = true,
          },
          grep = {
            hidden = true,
            -- ignored = true,
          },
        },
        -- Cấu hình lại phím tắt trên macOS để tránh xung đột với AeroSpace
        win = not is_mac and {} or {
          input = {
            keys = {
              -- 1. Vô hiệu hóa các phím Alt mặc định
              -- ["<a-c>"] = false,
              -- ["<a-t>"] = false,
              -- ["<a-s>"] = false,
              ["<a-i>"] = false,
              ["<a-h>"] = false,

              -- 2. Chuyển các chức năng tương ứng sang phím Ctrl
              -- ["<c-c>"] = { "toggle_cwd", mode = { "n", "i" } }, -- Đổi thư mục làm việc (CWD)
              -- ["<c-t>"] = { "trouble_open", mode = { "n", "i" } }, -- Mở danh sách bằng Trouble.nvim
              -- ["<c-s>"] = { "flash", mode = { "n", "i" } }, -- Tìm kiếm nhanh bằng Flash.nvim
              ["<c-i>"] = { "toggle_ignored", mode = { "n", "i" } }, -- Bật/tắt nhanh file trong .gitignore (thay cho <a-i>)
              ["<c-h>"] = { "toggle_hidden", mode = { "n", "i" } }, -- Bật/tắt nhanh file ẩn (thay cho <a-h> vì <c-h> thường trùng với Backspace/Left)
            },
          },
        },
      },
    },
  },
}
