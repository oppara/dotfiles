local VK_ESC = 53
local VK_ESCAPE = 102
local VK_LEFT_BRACKET = 33
local VK_J = 38

local function switchToUs()
    local cmd = '/usr/local/bin/keyboardSwitcher select U.S.'
    os.execute(cmd)
    -- hs.console.printStyledtext(cmd)
end


function flagsMatches(flags, modifiers)
    local set = {}
    for _, i in ipairs(modifiers) do set[string.lower(i)] = true end
    for _, j in ipairs({'fn', 'cmd', 'ctrl', 'alt', 'shift'}) do
        if set[j] ~= flags[j] then return false end
    end
    return true
end


keyEventtap = hs.eventtap.new({
    hs.eventtap.event.types.keyDown
}, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    -- hs.console.printStyledtext(keyCode)

    if keyCode == VK_ESC or keyCode == VK_ESCAPE then
        switchToUs()
    end

    if keyCode == VK_LEFT_BRACKET or keyCode == VK_J then
        if flagsMatches(flags, {'ctrl'}) then
            switchToUs()
        end
    end
end)

local function handleGlobalEvent(name, event, app)
    if event == hs.application.watcher.activated then
        local bundleId = string.lower(app.frontmostApplication():bundleID())
        if bundleId == 'com.apple.terminal' then
            keyEventtap:start()
        else
            keyEventtap:stop()
        end
    end
end
watcher = hs.application.watcher.new(handleGlobalEvent)
watcher:start()


