-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")
require("shifty")
--require("mail-simple")
--require("freedesktop.utils")
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/sky/theme.lua")
beautiful.init("/home/shtsh/.config/awesome/themes/strict/theme.lua")
--beautiful.init("themes/dwm/dwm.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
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
	
	-- screen 1	
	
	["term"]		= { init = true, position = 1, screen = 1, layout = awful.layout.suit.fair						 },
	["web"]			= { position = 2, screen = 1, layout = awful.layout.suit.fair, mwfact = 0.6, spawn = browser	 },
	["im"]			= { position = 3, screen = 1, layout = awful.layout.suit.tile.left, mwfact = 0.3	             },
	["skype"]		= { position = 4, screen = 1, layout = awful.layout.suit.fair,						             },
	["mail"]		= { position = 5, screen = 1, layout = awful.layout.suit.fullscreen	                			 },
	["picture"]		= { position = 6, screen = 1, layout = awful.layout.suit.max                 					 },
	["music"]		= { position = 7, screen = 1, layout = awful.layout.suit.tile.bottom                 			 },
	["multimedia"]	= { position = 8, screen = 1, layout = awful.layout.suit.fullscreen                   			 },
	["office"]		= { position = 9, screen = 1, layout = awful.layout.suit.tile.bottom                 			 },
}

--ws mail"                                 }, tag = "mail",                                                                           },                                
--shifty: tags matching and client rules
shifty.config.apps = {
	{ match = { "Namoroka", "Chromium", "Opera", "Firefox"       },	tag = "web", float = false,															},
	{ match = { "Pidgin" 								 }, tag = "im",																			},
	{ match = {  "Skype"										 }, tag = "skype",																		},
	{ match = { "Thunderbird"									 }, tag = "mail",																		},
	{ match = { "Claws Mail"								 }, tag = "mail",																		},
	{ match = { "^buddy_list"									 }, slave = false,																		},
--	{ match = { "Skype™ (Beta)"									 }, slave = false,																		},
	{ match = { "LibreOffice", "OpenOffice.org 3.2"       		 }, tag = "office",																		}, 
	{ match = { "Gimp"											 }, tag = "gimp",																		},
	{ match = { "gimp%-image%-window"							 }, geometry = {175,15,930,770}, border_width = 0										},
	{ match = { "^gimp%-toolbox$"								 }, geometry = {0,15,175,770}, slave = true, border_width = 1, ontop = true				},
	{ match = { "^gimp%-dock$"									 }, geometry = {1105,15,175,770}, slave = true, border_width = 1, ontop = true			},
--	{ match = { "^MPlayer", "Vlc", "Audacity"					 }, tag = "7-multimedia",																},
	{ match = { "Blender"										 }, tag = "multimedia",																	},
	{ match = { "xbmc.bin"										 }, tag = "multimedia",																	},
	{ match = { "^MPlayer"										 }, geometry = {0,15,nil,nil}, float = true, sticky=true, ontop=true                    },
	{ match = { "SMPlayer"										 }, float = true, ontop = true, sticky = true											},
	{ match = { "ncmpcpp", "Deadbeef", "Amarok"					 }, tag = "music",																		},
	{ match = { "rtorrent" , "Deluge"							 }, tag = "torrent",																	},
	{ match = { "GQview", "Geeqie", "Simple Viewer GL"					 }, tag = "picture",  													},
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
        { "skype", 'skype' },
        { browser, browser },
        { "mc", terminal .. " mc" },
        { "deadbeef", "deadbeef" },
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
				    { "halt", systemmenu }
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

-- {{{ Memory usage

-- Initialize widget
memwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, 
		 function (widget, args)
			if args[1] >= 60 and args[1] < 85 then
				return "" .. color_blue .. "<b>" .. args[1] .. "</b>% " .. color_default .. ""
			elseif args[1] >= 85 then
				--naughty.notify({ title = "Memory Warning", 
						 --text = args[1] .. "% Occupied!", 
						 --timeout = 10 })
				return "" .. color_red .. "<b>" .. args[1] .. "</b>% " .. color_default .. ""
			else 	return "<b>" .. args[1] .. "</b>% "
			end
		 end, 13)

memwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop") end ) ) )
--memwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_MEM") end ) ) )
-- }}}

-- {{{ CPU Usage 

cputwidget = widget({ type = "textbox" })
	vicious.register(cputwidget, vicious.widgets.cpu,
	function (widget, args)
		if  args[1] >= 60 and args[1] < 80 then
			return " " .. color_blue .. "<b>" ..  args[1] .. "</b>% " .. color_default .. "/"
		elseif args[1] >= 80 then
			return " " .. color_red .. "<b>" .. args[1] .. "</b>% " .. color_default .. "/"
		else
			return " <b>" .. args[1] .. "</b>% / "
		end
	end )
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop") end ) ) )
--cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )


-- }}}

-- {{{ Battery 

batwidget = widget({ type = "textbox" })
	vicious.register(batwidget, vicious.widgets.bat,
	function (widget, args)
		if args[1] == "-" then args[1] = "" end	
		
		if  args[2] < 30 and args[2] >= 15 and args[1] == "" then
			return "" .. color_blue .. "/ <b>" ..  args[2] .. "</b>% <b>" ..args[3] .. "</b> "  .. color_default .. ""
		elseif args[2] < 15 and args[1] == "" then
			return "" .. color_red .. "/ <b>" .. args[2] .. "</b>% <b>" .. args[3] .. "</b> " .. color_default .. ""
		elseif args[1] == "" then
			return "/ <b>" .. args[3] .. "</b> (<b>" .. args[1] .. args[2] .. "</b>%) "
		elseif args[1] == "+" then
			return "/ <b>" .. args[1] .. args[2] .. "</b>% <b>" .. args[3] .. "</b> "
		else
			return "/ <b>" .. args[1] .. "</b> "
		end
	end,
	60,
	"BAT0")
--battwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )


-- }}}

--{{{ Volume

volwidget = widget({type = "textbox"})
	vicious.register( volwidget,
					  vicious.widgets.volume,
					  function (widget, args)
						  if args[2] == "♩"  then
							  return " " .. args[2] .. "<b>M</b> "
						  else 
							  return  " " .. args[2] .. "<b>" .. args[1] .. "</b>"
						  end
					  end,
					  2,
					  "Master")

volwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e alsamixer") end ) ) )

--}}}

-- {{{ Weather
-- TODO Make weather widget

-- }}}

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
        {
	    mylauncher,
	    mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
		volwidget,
		--w_imap,
        --s == 1 and mysystray or nil,
        mysystray,
	batwidget,
	memwidget,
	cputwidget,
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


    awful.key({}, "Print", function () awful.util.spawn("scrot") end ),
    awful.key({modkeyctrl,	}, "Print", function () awful.util.spawn("scrot -s") end ),
    --awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle &") end  ),
    --awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+ &") end ),
    --awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%- &") end ),
    awful.key({}, "XF86AudioPrev", function () awful.util.spawn("deadbeef --prev &") end ),
    awful.key({}, "XF86AudioNext", function () awful.util.spawn("deadbeef --next &") end ),
    awful.key({}, "XF86AudioPlay", function () awful.util.spawn("deadbeef --pause &") end ),
    awful.key({}, "XF86AudioStop", function () awful.util.spawn("deadbeef --stop &") end ),
    
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
	
    awful.key({ modkey, "Shift"   }, "Left",                shifty.shift_prev        ),
    awful.key({ modkey, "Shift"   }, "Right",                 shifty.shift_next        ),
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
for i=1,9 do
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


-- {{{  Applications autorun

function run_once(prg)
	if not prg then
		do return nil end
	end
	awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

--run_once("deadbeef")
--run_once("xchat")
--run_once("dropboxd")

os.execute("pgrep -u $USER -x cl-launch-session || (ck-launch-session &)")
os.execute("pgrep -u $USER -x pidgin || (pidgin &)")
os.execute("pgrep -u $USER -x thunderbird|| (thunderbird &)")
os.execute("pgrep -u $USER -x deadbeef || (DISPLAY=:0.1 deadbeef &)")
os.execute("pgrep -u $USER -x skype || (skype &)")
--os.execute("pgrep -u $USER -x ossxmix || (ossxmix -b &)")
--os.execute("pgrep -u $USER -x chromium || (chromium &)")
os.execute("pgrep -u $USER -x libreoffice || (libreoffice -nologo -quickstart &)")
os.execute("pgrep -u $USER -x nm-applet || (nm-applet --sm-disable  &)")
os.execute("pgrep -u $USER -x bluetooth-applet || (bluetooth-applet &)")

os.execute("xsetroot -cursor_name left_ptr &")
-- }}}

