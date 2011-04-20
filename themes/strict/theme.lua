---------------------------
-- Strict awesome theme  --
-- by zhuravlik          --
---------------------------

theme = {}

theme.font          = "sans 8"
--theme.font          = "sans 8"

theme.bg_normal     = "#eeeeecee" --dd
theme.bg_focus      = "#4f5353ee"
theme.bg_urgent     = "#ff0000ee"
theme.bg_minimize   = "#303535ee"

theme.fg_normal     = "#505050"
--theme.fg_focus      = "#b9bbbb"
theme.fg_focus      = "#cacccc"
theme.fg_urgent     = "#f7f7f7"
theme.fg_minimize  = "#b9bbbb"

theme.border_width  = "1"
theme.border_normal = "#cbc8c1"
theme.border_focus  = "#282421"
theme.border_marked = "#f7f7f7"

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = "/home/shtsh/.config/awesome/themes/strict/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/shtsh/.config/awesome/themes/strict/taglist/square.png"

theme.tasklist_floating_icon = "/home/shtsh/.config/awesome/themes/strict/tasklist/floatingw.png"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/shtsh/.config/awesome/themes/strict/submenu.png"
theme.menu_height   = "15"
theme.menu_width    = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--bg_widget    = #cc0000

-- Define the image to load
theme.titlebar_close_button_normal = "/home/shtsh/.config/awesome/themes/strict/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "/home/shtsh/.config/awesome/themes/strict/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "/home/shtsh/.config/awesome/themes/strict/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "/home/shtsh/.config/awesome/themes/strict/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
--theme.wallpaper_cmd = { "awsetbg /home/shtsh/.config/wallpaper/Feared_and_Admired.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/shtsh/.config/awesome/themes/strict/layouts/fairh.png"
theme.layout_fairv = "/home/shtsh/.config/awesome/themes/strict/layouts/fairv.png"
theme.layout_floating = "/home/shtsh/.config/awesome/themes/strict/layouts/floating.png"
theme.layout_magnifier = "/home/shtsh/.config/awesome/themes/strict/layouts/magnifier.png"
theme.layout_max = "/home/shtsh/.config/awesome/themes/strict/layouts/max.png"
theme.layout_fullscreen = "/home/shtsh/.config/awesome/themes/strict/layouts/fullscreen.png"
theme.layout_tilebottom = "/home/shtsh/.config/awesome/themes/strict/layouts/tilebottom.png"
theme.layout_tileleft = "/home/shtsh/.config/awesome/themes/strict/layouts/tileleft.png"
theme.layout_tile = "/home/shtsh/.config/awesome/themes/strict/layouts/tile.png"
theme.layout_tiletop = "/home/shtsh/.config/awesome/themes/strict/layouts/tiletop.png"

--theme.awesome_icon = "/home/shtsh/.config/awesome/icons/awesome16.png"
theme.awesome_icon = "/home/shtsh/.config/awesome/themes/strict/awesome-icon-3.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
