local lib = require('lib.lib')

require('bufferline').setup({
    options = {
        numbers = 'none',
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_tab_indicators = false,
        show_close_icon = false,
        separator_style = 'thin',
        tab_size = 0,
        diagnostics = 'nvim_lsp',
    },
})

lib.map('n', '<Leader>s', ':BufferLinePick<CR>')
lib.map('n', '<Leader>S', ':BufferLinePickClose<CR>')
