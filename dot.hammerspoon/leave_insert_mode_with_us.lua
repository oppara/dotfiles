local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function switchToUs()
    local cmd = '/usr/local/bin/keyboardSwitcher select U.S.'
    os.execute(cmd)
    hs.console.printStyledtext(cmd)
end

local ctrlBracket = hs.hotkey.bind({'ctrl'}, '[', keyCode('escape'), switchToUs)
local ctrlJ = hs.hotkey.bind({'ctrl'}, 'j', keyCode('escape'), switchToUs)

local function handleGlobalEvent(name, event, app)
    if event == hs.application.watcher.activated then
        local bundleId = string.lower(app.frontmostApplication():bundleID())
        if bundleId == 'com.apple.terminal' then
            ctrlBracket:enable()
            ctrlJ:enable()
        else
            ctrlBracket:disable()
            ctrlJ:disable()
        end
    end
end
watcher = hs.application.watcher.new(handleGlobalEvent)
watcher:start()


