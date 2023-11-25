function AC_register_tool(name, short_id, hotkey, entity_id, tool_size, use_callback, icon_path, erase_callback)
    table.insert(toolnames, name)
    table.insert(subtoolnames, {})
    table.insert(subtoolimgs, {})
    if entity_id then
        table.insert(entitytooltoid, entity_id)
    end

    table.insert(toolimg, love.graphics.newImage(icon_path .. ".png"))
    table.insert(toolimgicon, love.image.newImageData(icon_path .. "_on.png"))

    table.insert(toolshortcuts, hotkey)

    AC_CUSTOM_TOOLS[#toolnames] = {
        cursor = tool_size,
        use = use_callback,
        erase = erase_callback or function() end
    }

    return #toolnames
end

function AC_register_click_handler(handler)
    table.insert(AC_ON_CLICK_HOOKS, handler)
end

function AC_register_entity_render_handler(handler)
    table.insert(AC_DRAW_ENTITY_HOOKS, handler)
end

function AC_register_entity_menu_handler(handler)
    table.insert(AC_CREATE_ENTITY_MENU_HOOKS, handler)
end

function AC_DRAW_ENTITY(entity, type, x, y, k, interact, offsetx, offsety, myroomx, myroomy, scriptname_args,
                        nthscriptbox)
    AC_SCRIPTNAME_SHOWN = false

    for i = 1, #AC_DRAW_ENTITY_HOOKS do
        local v = AC_DRAW_ENTITY_HOOKS[i]
        if v(entity, type, x, y, k, interact, offsetx, offsety, myroomx, myroomy, scriptname_args, nthscriptbox) then
            return true
        end
    end

    return false
end

function AC_CREATE_ENTITY_MENU(type)
    for i = 1, #AC_CREATE_ENTITY_MENU_HOOKS do
        local v = AC_CREATE_ENTITY_MENU_HOOKS[i]
        if v(type) then
            return v(type)
        end
    end
end

function AC_ON_CLICK(atx, aty)
    local mouse_x, mouse_y = (getlockablemouseX() - screenoffset), getlockablemouseY()

    for i = 1, #AC_ON_CLICK_HOOKS do
        local v = AC_ON_CLICK_HOOKS[i]
        if v(atx, aty, mouse_x, mouse_y) then
            return true
        end
    end

    return false
end

function string:split(sSeparator, nMax, bRegexp)
    assert(sSeparator ~= '')
    assert(nMax == nil or nMax >= 1)

    local aRecord = {}

    if self:len() > 0 then
        local bPlain = not bRegexp
        nMax = nMax or -1

        local nField, nStart = 1, 1
        local nFirst, nLast = self:find(sSeparator, nStart, bPlain)
        while nFirst and nMax ~= 0 do
            aRecord[nField] = self:sub(nStart, nFirst - 1)
            nField = nField + 1
            nStart = nLast + 1
            nFirst, nLast = self:find(sSeparator, nStart, bPlain)
            nMax = nMax - 1
        end
        aRecord[nField] = self:sub(nStart)
    end

    return aRecord
end

function AC_table_array_contains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
        if type(v) == "table" then
            if AC_table_equals(v, value) then
                return true
            end
        end
    end
    return false
end

function AC_table_equals(tbl1, tbl2)
    if #tbl1 ~= #tbl2 then
        return false
    end
    for i, v in ipairs(tbl1) do
        if v ~= tbl2[i] then
            if type(v) == "table" then
                if not AC_table_equals(v, tbl2[i]) then
                    return false
                end
            else
                return false
            end
        end
    end
    return true
end

function AC_add_internal_script(name, contents, replace)
    internalscript = true
    outpost_add_script(name, contents, replace)
    internalscript = false
end

function AC_add_script(name, contents, replace)
    if replace or (not table.contains(scriptnames, name)) then
        success, contents = script_compile(contents)
        scripts[name] = contents
    end
    if not table.contains(scriptnames, name) then
        table.insert(scriptnames, name)
    end
end

function AC_script_exists(name)
    return table.contains(scriptnames, name)
end
