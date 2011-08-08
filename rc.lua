-- Standard awesome library require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Monitoring widgets library
require("vicious")
-- Dynamic tag library
require("shifty")
--require("freedesktop.utils")

-- {{{ Variable definitions

-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/strict/theme.lua")

-- {{{ Naughty config
naughty.config.default_preset.position         =  "bottom_right"
naughty.config.default_preset.bg               =    '#dddddd'
naughty.config.default_preset.fg               =    '#000000'
naughty.config.default_preset.font             =  "Droid Sans 10"
-- }}}

-- This is used later as the default terminal and editor to run.
--terminal = "xterm"
terminal = "gnome-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
--browser = "firefox"
browser = "chromium"

--freedesktop.utils.terminal = terminal
--require("freedesktop.menu")
--menu_items = freedesktop.menu.new()

-- COLORS
color_default = "</span>"
color_black = "<span color='#000000'>"
color_white = "<span color='#ffffff'>"
color_yellow = "<span color='#ffff00'>"
color_red = "<span color='#ff0000'>"
color_blue = "<span color='#0000ff'>"
color_green = "<span color='#00ff00'>"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
modkeyalt = "Mod1"
modkeyctrl = "Mod2"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
  --    awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.max,
  awful.layout.suit.fair,
  awful.layout.suit.floating,
  --    awful.layout.suit.fair.horizontal,
  --    awful.layout.suit.spiral,
  --    awful.layout.suit.spiral.dwindle,
  --    awful.layout.suit.max,
  --    awful.layout.suit.max.fullscreen,
  --    awful.layout.suit.magnifier
}


-- }}}

-- shifty: predefined tags
shifty.config.tags = {
  ["work"]    = { init = true, position = 1, screen = 1, layout = awful.layout.suit.fair                     },
  ["web"]     = { position = 2, screen = 1, layout = awful.layout.suit.fair, mwfact = 0.6, spawn = browser, max_clients = 2  },
  ["im"]      = { position = 3, screen = 1, layout = awful.layout.suit.tile.left, mwfact = 0.3                 },
  ["mail"]    = { position = 5, screen = 1, layout = awful.layout.suit.fullscreen , max_clients = 1                      },
  ["picture"]   = { position = 6, screen = 1, layout = awful.layout.suit.max, max_clients = 1                            },
  ["music"]   = { position = 10, screen = 1, layout = awful.layout.suit.tile.bottom, max_clientst = 1                        },
  ["wine"]    = { position = 7, screen = 1, layout = awful.layout.suit.max.fullscreen, exclusive = true                        },
  ["office"]    = { position = 9, screen = 1, layout = awful.layout.suit.tile.bottom, max_clients = 1                        },
  ["read"]    = { position = 8, screen = 1, layout = awful.layout.suit.fullscreen, max_clients = 1                       },
  ["irc"]     = { position = 0, screen = 1, layout = awful.layout.suit.fullscreen, max_clients = 1                       },
}

--shifty: tags matching and client rules
shifty.config.apps = {
  { match = { "luakit", "Chromium", "Opera", "Firefox"     }, tag = "web", float = false,                             },
  { match = { "Pidgin"                     }, tag = "im",                                     },
  { match = { "Wine"                       }, tag = "wine",                                   },
  { match = {  "Skype"                     }, tag = "im",                                    },
  { match = {  "CoolReader", "Apvlv"               }, tag = "read",                                   },
  { match = { "Thunderbird"                  }, tag = "mail",                                   },
  { match = { "Claws Mail"                   }, tag = "mail",                                   },
  { match = { "buddy_list"                   }, slave = true,                                   },
  { match = { "LibreOffice", "OpenOffice.org 3.2"            }, tag = "office",                                   }, 
  { match = { "Gimp"                       }, tag = "gimp",                                   },
  { match = { "gimp%-image%-window"              }, geometry = {231,20,905,750}, border_width = 0                   },
  { match = { "^gimp%-toolbox$"                }, geometry = {0,20,230,750}, slave = true, border_width = 1, ontop = true       },
  { match = { "^gimp%-dock$"                   }, geometry = {1136,20,230,760}, slave = true, border_width = 1, ontop = true      },
  { match = { "XChat"                      }, tag = "irc",                                    },
  { match = { "^MPlayer"                     }, geometry = {0,15,nil,nil}, float = true, sticky=true, ontop=true                    },
  { match = { "SMPlayer"                     }, float = true, ontop = true, sticky = true                     },
  { match = { "ncmpcpp", "Deadbeef", "Amarok", "Clementine"  }, tag = "music",                                    },
  { match = { "rtorrent" , "Deluge", "Transmission"      }, tag = "torrent",                                  },
  { match = { "GQview", "Geeqie", "Simple Viewer GL", "Xnview" }, tag = "picture",                            },
  -- client manipulation
  { match = { "" },
  honorsizehints = false,
  buttons = awful.util.table.join (
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))
},
}

-- shifty: defaults
shifty.config.defaults = {
  layout = awful.layout.suit.max,
}
shifty.config.layouts = layouts
shifty.init()



-- {{{ Menu
-- Create a laucher widget and a main menu

programsmenu = {
  { "pidgin", 'pidgin' },
  { browser, browser },
  { "deadbeef", "deadbeef" },
  { "xchat", "xchat" },
}

myawesomemenu = {
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}

systemmenu = {
  {"shutdown", "sudo halt"},
  {"reboot", "sudo reboot"}
}

mymainmenu = awful.menu({ items = { { "programs", programsmenu }, 
{ "awesome", myawesomemenu, beautiful.awesome_icon },
{ "open terminal", terminal },
{ "halt", systemmenu },
{ "lock", "slimlock" } } })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- {{{ Memory usage

-- Initialize widget
memwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, 
function (widget, args)
  if args[1] >= 60 and args[1] < 85 then
    return "" .. color_blue .. "<b>" .. args[1] .. "</b>%" .. color_default .. ""
  elseif args[1] >= 85 then
    return "" .. color_red .. "<b>" .. args[1] .. "</b>%" .. color_default .. ""
  else  return  "<b>" .. args[1] .. "</b>%"
  end
end, 13)

-- Run htop on click
memwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop") end ) ) )

-- don't works with --sort-key (seems bug)
--memwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_MEM") end ) ) )
-- }}}

-- {{{ CPU Usage 

cputwidget = widget({ type = "textbox" })
vicious.register(cputwidget, vicious.widgets.cpu,
function (widget, args)
  if  args[1] >= 60 and args[1] < 80 then
    return "" .. color_blue .. "<b>" ..  args[1] .. "</b>%" .. color_default .. ""
  elseif args[1] >= 80 then
    return "" .. color_red .. "<b>" .. args[1] .. "</b>%" .. color_default .. ""
  else
    return "<b>" .. args[1] .. "</b>%"
  end
end )

-- run htop on click
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop") end ) ) )
--cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )


-- }}}

-- {{{ Battery 
-- Format: 
--       +percent time_min:time_sec when charging.
--       time_min:time_sec (percent) on battery
--       ↯ when charged

batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat,
function (widget, args)

  -- s2disk when low battery charge 
  if args[2] < 2 and args[1] == "-" then awful.util.spawn("sudo hibernate") end

  -- different widget appearance
  --
  b_dis = "▼ "
  b_cha = "▲ "


  if  args[2] < 30 and args[2] >= 15 and args[1] == "-" then
    return "" .. color_blue .. "<b>" .. b_dis ..  args[2] .. "</b>% <b>" ..args[3] .. "</b>"  .. color_default .. ""
  elseif args[2] < 15 and args[1] == "-" then
    return "" .. color_red .. "<b>" .. b_dis.. args[2] .. "</b>% <b>" .. args[3] .. "</b>" .. color_default .. ""
  elseif args[1] == "-" then
    return "<b>" .. b_dis .. args[2].. "</b>% (<b>" .. args[3] .. "</b>)"
  elseif args[1] == "+" then
    return "" .. b_cha .. "<b>" .. args[2] .. "</b>%"
  else
    return "<b>" .. args[1] .. "</b>"
  end
end,
60,
"BAT0")

-- }}}

--{{{ Volume
-- Format:

volwidget = widget({type = "textbox", name = "volwidget"})

--function volume(command,widget)
  --if command == "update" then
    --local fd = io.popen("amixer sget Master")
    --local status = fd:read("*all")
    --fd:close()

    --local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))

    --if (string.find(status, "off", 1, true)) then
      --ret = "" .. color_white .. "<b>Muted</b>" .. color_default .. ""
      --volwidget.bg = beautiful.fg_normal
    --else
      --ret = "♫ <b>" .. volume .. "</b>"
      --volwidget.bg = beautiful.fg_focus
    --end
    --widget.text = ret
  --elseif command == "raise" then
    --awful.util.spawn("amixer set Master 5%+ &")
    --volume("update",volwidget)
  --elseif command == "lower" then
    --awful.util.spawn("amixer set Master 5%- &")
    --volume("update",volwidget)
  --elseif command == "toggle" then
    --awful.util.spawn("amixer set Master toggle &")
    --volume("update",volwidget)
  --end
--end
--volume("update",volwidget)

-- Autorefresh every 2 minutes
awful.hooks.timer.register(120, function () volume("update", volwidget) end)

-- Alsamixer on click
volwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e alsamixer") end ) ) )
--volwidget:buttons(awful.util.table.join(awful.button({}, 3, function () awful.util.spawn ( "amixer set Master toggle") end ) ) )

--}}}

-- {{{ Weather
-- TODO Make weather widget

-- }}}
--

-- {{{ Keyboard Layouts
-- Keyboard map indicator and changer
    kbdcfg = {}
    kbdcfg.cmd = "setxkbmap"
    kbdcfg.layout = awful.widget.layout.horizontal.rightleft
    kbdcfg.layouts = { { "us", "dvp" }, { "ru", "" } }
    kbdcfg.layouts_count = 2
    kbdcfg.current = 1  -- us is our default layouts
    kbdcfg.widget = widget({ type = "textbox", align = "right" })
    kbdcfg.widget.text = " " .. kbdcfg.layouts[kbdcfg.current][1] .. " "
    kbdcfg.switch = function ()
       kbdcfg.current = kbdcfg.current % kbdcfg.layouts_count + 1
       local t = kbdcfg.layouts[kbdcfg.current]
       kbdcfg.widget.text = " " .. t[1] .. " "
       os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
    end

-- Mouse bindings
    kbdcfg.widget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () kbdcfg.switch() end)
    ))

-- }}}


dummyw = widget ({type = "textbox" })
dummyw.text = "  "
dummyw1 = widget ({type = "textbox" })
dummyw1.text = " "
divider = widget ({type = "textbox" })
divider.text = " | "

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                      awful.button({ }, 1, awful.tag.viewonly), 
                      awful.button({ modkey }, 1, awful.client.movetotag),
                      awful.button({ }, 3, awful.tag.viewtoggle),
                      awful.button({ modkey }, 3, awful.client.toggletag),
                      awful.button({ }, 4, awful.tag.viewnext),
                      awful.button({ }, 5, awful.tag.viewprev)
                    )

shifty.taglist = mytaglist

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
  if not c:isvisible() then
    awful.tag.viewonly(c:tags()[1])
  end
  client.focus = c
  c:raise()
end),
awful.button({ }, 3, function ()
  if instance then
    instance:hide()
    instance = nil
  else
    instance = awful.menu.clients({ width=250 })
  end
end),
awful.button({ }, 4, function ()
  awful.client.focus.byidx(1)
  if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
  awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(function(c)
    return awful.widget.tasklist.label.currenttags(c, s)
  end, mytasklist.buttons)

  -- Create the wibox
  mywibox[s] = awful.wibox({ position = "top", screen = s })

  -- Add widgets to the wibox - order matters
  mywibox[s].widgets = {
    { mylauncher,
      mytaglist[s],
      mypromptbox[s],
      layout = awful.widget.layout.horizontal.leftright
    },
  mylayoutbox[s],
  mytextclock,
  dummyw1,
  kbdcfg,
  dummyw,
  volwidget,
  dummyw,
  mysystray,
  dummyw,
  batwidget,
  divider,
  memwidget,
  divider,
  cputwidget,
  dummyw,
  mytasklist[s],
  layout = awful.widget.layout.horizontal.rightleft
}
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

-- Alt + Left Shift switches the current keyboard layout
awful.key({ "Mod1" }, "Shift_L", function () kbdcfg.switch() end),

-- PreentScreen with scrot
awful.key({           }, "Print", function () awful.util.spawn("scrot") end ),
awful.key({modkeyctrl,      }, "Print", function () awful.util.spawn("scrot -s") end ),
awful.key({}, "XF86AudioMute", function () volume("toggle", volwidget) end ),
awful.key({}, "XF86AudioRaiseVolume", function () volume("raise",volwidget) end),
awful.key({}, "XF86AudioLowerVolume", function () volume("lower",volwidget) end ),

-- Deadbeef audio player control with multimedia keys
--    awful.key({           }, "XF86AudioPrev", function () awful.util.spawn("clementine --previous") end ),
--   awful.key({            }, "XF86AudioNext", function () awful.util.spawn("clementine --next") end ),
--   awful.key({            }, "XF86AudioPlay", function () awful.util.spawn("clementine --play-pause") end ),
--   awful.key({            }, "XF86AudioStop", function () awful.util.spawn("clementine --stop") end ),
awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

awful.key({ modkey, "Shift"   }, "Left",                shifty.shift_prev        ),
awful.key({ modkey, "Shift"   }, "Right",                 shifty.shift_next        ),

-- add temporary "tmp-Work" tag 
awful.key({ modkey            }, "a",                    function() shifty.add({ rel_index = 1 , name = "tmp-Work"}) end ),
awful.key({ modkey, "Shift"   }, "a",                    function() shifty.add({ rel_index = 1, nopopup = true, name = "tmp-Work" }) end ),
awful.key({ modkey            }, "z",                    shifty.del ),

awful.key({ modkey,           }, "j",
function ()
  awful.client.focus.byidx( 1)
  if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "k",
function ()
  awful.client.focus.byidx(-1)
  if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
awful.key({ modkey,           }, "Tab",
function ()
  awful.client.focus.history.previous()
  if client.focus then
    client.focus:raise()
  end
end),

-- Standard program
awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
awful.key({ modkey, "Control" }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),

awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

-- Prompt
awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

awful.key({ modkey }, "x",
function ()
  awful.prompt.run({ prompt = "Run Lua code: " },
  mypromptbox[mouse.screen].widget,
  awful.util.eval, nil,
  awful.util.getdir("cache") .. "/history_eval")
end)
)

clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
awful.key({ modkey,           }, "m",
function (c)
  c.maximized_horizontal = not c.maximized_horizontal
  c.maximized_vertical   = not c.maximized_vertical
end)
)


clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

-- WORKSPACES
-- shifty:
for i=0,9 do
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, i, function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, i, function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, i, function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, i, function ()
    if client.focus then
      local t = shifty.getpos(i)
      awful.client.movetotag(t)
      awful.tag.viewonly(t)
    end
  end))
end

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
  -- Add a titlebar
  -- awful.titlebar.add(c, { modkey = modkey })

  -- Enable sloppy focus
  c:add_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    awful.client.setslave(c)

    -- Put windows in a smart way, only if they does not set an initial position.
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end

-- {{{  Applications autorun

function run_once(prg)
  if not prg then
    do return nil end
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

run_once("deadbeef")
--run_once("xchat")
run_once("dropboxd")
os.execute("pgrep -u $USER -x nm-applet || (nm-applet --sm-disable  &)")
os.execute("pgrep -u $USER -x bluetooth-applet || (bluetooth-applet &)")
os.execute("syndaemon -t -k -i 2 -d &") -- disable touchpad while typing
os.execute("setxkbmap us dvp")
os.execute("xscreensaver -nosplash")

--os.execute("pgrep -u $USER -x pidgin || (pidgin &)")
--os.execute("pgrep -u $USER -x skype || (skype &)")
--os.execute("pgrep -u $USER -x ossxmix || (ossxmix -b &)")
--os.execute("pgrep -u $USER -x chromium || (chromium &)")
--os.execute("pgrep -u $USER -x libreoffice || (libreoffice -nologo -quickstart &)")
--os.execute("xsetroot -cursor_name left_ptr &")
-- }}}

