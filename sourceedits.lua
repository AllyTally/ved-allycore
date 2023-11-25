sourceedits =
{
	["uis/maineditor/draw"] =
	{
		{
			find = [[
		elseif not (selectedtool == 13 and selectedsubtool[13] == 2) then]],
			replace = [[
		elseif AC_CUSTOM_TOOLS[selectedtool] then
			local custom_tool = AC_CUSTOM_TOOLS[selectedtool]
			-- Custom tool
			displayshapedcursor(unpack(custom_tool.cursor))
		elseif not (selectedtool == 13 and selectedsubtool[13] == 2) then]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false
		},
		{
			find = [[
for t = 1, 17 do]],
			replace = [[
for t = 1, #toolnames do]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false
		}
	},
	["func"] =
	{
		{
			find = [[
local max_scroll = 368
]],
			replace = [[
local max_scroll = (#toolnames * 48) - 448
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["tool_mousedown"] =
	{
		{
			find = [[
elseif love.mouse.isDown("l") and not mousepressed then]],
			replace = [[
elseif love.mouse.isDown("l") and AC_CUSTOM_TOOLS[selectedtool] then
	AC_CUSTOM_TOOLS[selectedtool].use(atx, aty, roomx, roomy)
elseif love.mouse.isDown("r") and AC_CUSTOM_TOOLS[selectedtool] then
	AC_CUSTOM_TOOLS[selectedtool].erase(atx, aty, roomx, roomy)
elseif love.mouse.isDown("l") and not mousepressed then
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		},
		{
			find = [[
elseif selectedtool <= 3 then]],
			replace = [[
elseif AC_ON_CLICK(atx, aty) then
    -- handled already
elseif selectedtool <= 3 then]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["uis/maineditor/keypressed"] =
	{
		{
			find = [[
selectedtool = 17]],
			replace = [[
selectedtool = #toolnames]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		},
		{
			find = [[
local tool_count = 17]],
			replace = [[
local tool_count = #toolnames]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		},
		{
			find = [[for k,v in pairs(toolshortcuts) do]],
			replace = [[
		if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
			key = "s" .. key
		end
		for k,v in pairs(toolshortcuts) do]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["uis/maineditor/wheelmoved"] =
	{
		{
			find = [[
selectedtool = 17]],
			replace = [[
selectedtool = #toolnames]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		},
		{
			find = [[
local tool_count = 17]],
			replace = [[
local tool_count = #toolnames]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["roomfunc"] =
	{
		{
			find = [[
	else
		-- We don't know what this is, actually!]],
			replace = [[
	elseif AC_DRAW_ENTITY(v, v.t, x, y, k, interact, offsetx, offsety, myroomx, myroomy, scriptname_args, nthscriptbox) then
		-- The function call already took care of drawing!
		if AC_SCRIPTNAME_SHOWN then
			scriptname_shown = AC_SCRIPTNAME_SHOWN
		end
		AC_SCRIPTNAME_SHOWN = false
	else
		-- We don't know what this is, actually!]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["entity_mousedown"] =
	{
		{
			find = [[
				else
					-- We don't know what this is, actually!
]],
			replace = [[
				elseif AC_CREATE_ENTITY_MENU(v.t) then
					menu = AC_CREATE_ENTITY_MENU(v.t)
				else
					-- We don't know what this is, actually!
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	}
}
