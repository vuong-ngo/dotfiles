#!/bin/bash

# ----------------------------------------------------- 
# Hyprland Keybindings Cheat Sheet - Sync with Config
# ----------------------------------------------------- 

# Danh sách phím tắt được định dạng cho Rofi
bindings="󰞷 SUPER + Return 🡒 Mở Terminal (Kitty)
󰉋 SUPER + E 🡒 Quản lý file (Nautilus)
󰍉 SUPER + A 🡒 Menu ứng dụng (Rofi)
󰓇 SUPER + F 🡒 Chạy app bằng NVIDIA (Prime)
󰈹 ALT + Tab 🡒 Chuyển đổi cửa sổ (Rofi Window)
󰅖 SUPER + Q / F4 🡒 Đóng cửa sổ đang chọn
󰊓 F11 🡒 Toàn màn hình (Fullscreen)
󰏫 SUPER + W 🡒 Bật/Tắt cửa sổ nổi (Floating)
󰒲 SUPER + S 🡒 Ẩn nhanh vào ngăn kéo (Minimize)
󰇄 SUPER + \` (Grave) 🡒 Mở ngăn kéo bí mật (Special)
󰃠 SUPER + SHIFT + P 🡒 Cấu hình màn hình
󰄀 SHIFT + ALT + S 🡒 Chụp ảnh vùng màn hình
󰄀 SHIFT + Print 🡒 Chụp ảnh cửa sổ
󰄀 SUPER + Print 🡒 Chụp toàn bộ màn hình
󰅏 SUPER + V 🡒 Quản lý Clipboard (Lịch sử copy)
󰂚 SUPER + N 🡒 Trung tâm thông báo (SwayNC)
󰂫 SUPER + O 🡒 Đổi hướng chia cửa sổ (Togglesplit)
󰡨 SUPER + Tab 🡒 Quay lại Workspace vừa dùng
󰸉 SUPER + CTRL + ALT + Ins 🡒 Chọn hình nền
󰌾 SUPER + CTRL + ALT + L 🡒 Khóa màn hình (Hyprlock)
󰐥 SUPER + CTRL + ALT + Del 🡒 Thoát Hyprland
󰐥 SUPER + CTRL + ALT + Pause 🡒 Menu Nguồn (Power)
󰆊 SUPER + Arrows 🡒 Di chuyển tiêu điểm chuột
󰖲 SUPER + SHIFT + Arrows 🡒 Thay đổi kích thước cửa sổ
󰎧 SUPER + [1-0] 🡒 Chuyển Workspace
󰚀 SUPER + SHIFT + [1-0] 🡒 Di chuyển cửa sổ tới Workspace
󰚀 SUPER + CTRL + Down 🡒 Tìm Workspace trống đầu tiên"

# Chạy Rofi để hiển thị danh sách
echo -e "$bindings" | rofi -dmenu -i -p "⌨️ Hệ thống phím tắt:" -theme ~/.config/rofi/scripts/keybindings-menu/keybindings-menu.rasi
