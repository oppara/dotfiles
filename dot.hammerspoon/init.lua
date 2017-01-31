require('press_cmd_q_twice_to_quit')
require('leave_insert_mode_with_us')


function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == '.lua' then
            hs.reload()
            break
        end
    end
end
hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()
hs.alert.show('config loaded')
