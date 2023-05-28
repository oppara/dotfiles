local u = require('utils')

local surround = u.usePlugin('nvim-surround')
if not surround then
    return
end

surround.buffer_setup({
    surrounds = {
      ['e'] = {
        add = { '<?= ', '; ?>' },
      },
      ['p'] = {
        add = { '<?php ', '; ?>' },
      },
    }

  })

  -- autocmd FileType php let b:surround_{char2nr('e')} = "<?php echo \r; ?>"
        -- \| let b:surround_{char2nr('p')} = "<?php \r; ?>"
        -- \| let b:surround_{char2nr('i')} = "__('\r');"
        -- \| let b:surround_{char2nr('I')} = "<?php echo __('\r'); ?>"
