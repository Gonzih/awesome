-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Dynamic tag library
require("shifty")
-- Vicious
require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
theme = beautiful.init("/usr/share/awesome/themes/default/theme.lua")

color_default = '#aaaaaa'
color_red = '#ff0000'

-- This is used later as the default terminal and editor to run.
local term     = "sakura"
terminal = term .. " -e 'tmux'"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = 'gvim'

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

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


-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3 }, s, layouts[1])
end
-- }}}

-- {{{ Shifty
--shifty: predefined tags
screen_1 = 1
screen_2 = math.max(screen.count(), 2)

shifty.config.tags = {
  ["dev"]     = { position = 1, screen  = screen_2, layout = awful.layout.suit.fair,           init         = true            },
  ["web"]     = { position = 2, screen  = screen_2, layout = awful.layout.suit.fair,           max_clients  = 1, mwfact = 0.6 },
  ["im"]      = { position = 3, screen  = screen_1, layout = awful.layout.suit.tile.left,      mwfact       = 0.3             },
  ["skype"]   = { position = 4, screen  = screen_1, layout = awful.layout.suit.tile.left,      mwfact       = 0.3             },
  ["mail"]    = { position = 5, screen  = screen_1, layout = awful.layout.suit.fullscreen ,    max_clients  = 1               },
  ["picture"] = { position = 6, screen  = screen_1, layout = awful.layout.suit.max,            max_clients  = 1               },
  ["wine"]    = { position = 7, screen  = screen_2, layout = awful.layout.suit.max.fullscreen, exclusive    = true            },
  ["read"]    = { position = 8, screen  = screen_2, layout = awful.layout.suit.fullscreen,     max_clients  = 1               },
  ["office"]  = { position = 9, screen  = screen_2, layout = awful.layout.suit.tile.bottom,    max_clients  = 1               },
  ["irc"]     = { position = 0, screen  = screen_1, layout = awful.layout.suit.fullscreen,     max_clients  = 1               },
  ["music"]   = { position = 10, screen = screen_1, layout = awful.layout.suit.tile.bottom,    max_clientst = 1               },
  ["torrent"] = { position = 11, screen = screen_1, layout = awful.layout.suit.tile.bottom,    max_clientst = 1               }
}

--shifty: tags matching and client rules
shifty.config.apps = {
  { match = { "luakit", "Chromium", "Opera", "Firefox", "Google Chrome" }, tag = "web", float = false, },
  { match = { "Pidgin", "Empathy", "Chat"                               }, tag = "im",                 },
  { match = { "Wine"                                                    }, tag = "wine",               },
  { match = { "Skype"                                                   }, tag = "skype",              },
  { match = { "CoolReader", "Apvlv"                                     }, tag = "read",               },
  { match = { "Thunderbird"                                             }, tag = "mail",               },
  { match = { "Claws Mail"                                              }, tag = "mail",               },
  { match = { "..LibreOffice...", "OpenOffice.org 3.2"                  }, tag = "office",             },
  { match = { "Gimp"                                                    }, tag = "gimp",               },
  { match = { "XChat"                                                   }, tag = "irc",                },
  { match = { "ncmpcpp", "Deadbeef", "Amarok", "Clementine"             }, tag = "music",              },
  { match = { "rtorrent" , "Deluge", "Transmission"                     }, tag = "torrent",            },
  { match = { "GQview", "Geeqie", "Simple Viewer GL", "Xnview"          }, tag = "picture",            },

  { match = { "buddy_list" }, slave = true,                             },
  { match = { "SMPlayer"   }, float = true, ontop = true, sticky = true },

  { match = { "^MPlayer"            }, geometry = {0,15,nil,nil    }, float = true, sticky=true, ontop=true        },
  { match = { "gimp%-image%-window" }, geometry = {231,20,905,750  }, border_width = 0                             },
  { match = { "^gimp%-toolbox$"     }, geometry = {0,20,230,750    }, slave = true, border_width = 1, ontop = true },
  { match = { "^gimp%-dock$"        }, geometry = {1136,20,230,760 }, slave = true, border_width = 1, ontop = true },

  --client manipulation
  {
          match = { "" },
          honorsizehints = false,
          buttons = awful.util.table.join (
          awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
          awful.button({ modkey }, 1, awful.mouse.client.move),
          awful.button({ modkey }, 3, awful.mouse.client.resize))
  },
}

--shifty: defaults
shifty.config.defaults = {
  layout = awful.layout.suit.max,
}
shifty.config.layouts = layouts
shifty.init()

-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", term .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { 'awesome', myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal },
                                    { 'Chrome', 'google-chrome' },
                                    { 'Chromium', 'chromium' },
                                    { 'Firefox', 'firefox' },
                                    { 'halt', 'sudo halt' },
                                    { 'reboot', 'sudo reboot' }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

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
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
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
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
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
    awful.key({ modkey, "Shift" }, "d", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Shift" }, "n", function () awful.screen.focus_relative(1)  end),

    awful.key({ modkey, }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey, }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, }, "d",   awful.tag.viewprev       ),
    awful.key({ modkey, }, "n",  awful.tag.viewnext       ),

    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "h",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "t",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "h", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "t", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "h", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "t", function () awful.screen.focus_relative(-1) end),
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

    awful.key({ modkey,           }, "j",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "k",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "j",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "k",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "j",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "k",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

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
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
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
        -- awful.client.setslave(c)

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
