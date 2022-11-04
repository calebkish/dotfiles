local lib = require('lib.lib')
local U = require('pepita.utils')

local function is_special_buffer(buf_name)
    return (
        vim.startswith(buf_name, 'term://') or
        vim.startswith(buf_name, '[dap-terminal]')
    )
end

local function get_buffers()
    local buffers = {}
    local len = 0

    for buffer = 1, vim.fn.bufnr('$') do
        if vim.fn.buflisted(buffer) == 1 then
            len = len + 1
            buffers[len] = buffer
        end
    end

    return buffers
end


local function get_term_buffers()
    local buf_nums = get_buffers()

    return U.list_filter(buf_nums, function(buf_num)
        local buf_name = vim.fn.bufname(buf_num)
        return is_special_buffer(buf_name)
    end)
end


vim.api.nvim_create_user_command('GetTermBufs', function()
    P(get_term_buffers())
end, { nargs = 0 })


local function get_term_status_line()
    local s = ''

    local cur_buf = vim.api.nvim_get_current_buf()
    local term_bufs = get_term_buffers()

    for index, buf_num in ipairs(term_bufs) do
        if buf_num == cur_buf then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end
        s = s .. ' ' .. index  .. ' '
        index = index + 1
    end

    s = s .. '%#TabLineFill#'

    return s
end

local function get_win_with_term_buf()
    local wins = vim.api.nvim_tabpage_list_wins(0)

    for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.fn.bufname(buf)
        if is_special_buffer(buf_name) then
            return win
        end
    end

    return nil
end


local function open_terminal()
    local win = get_win_with_term_buf()

    if win == nil then
        local term_bufs = get_term_buffers()

        if #term_bufs == 0 then
            vim.cmd('split term://zsh')
            return
        end

        vim.cmd('sbuffer ' .. term_bufs[1])
        return
    end

    local cmd_buf = vim.api.nvim_win_get_buf(win)
    local cur_buf = vim.api.nvim_get_current_buf()
    if cmd_buf ~= cur_buf then
        vim.api.nvim_set_current_win(win)
    end
end

lib.map('', '<C-t>', '<Nop>', { callback = function()
    local win = get_win_with_term_buf()
    if win then
        vim.api.nvim_win_close(win, { force = false })
    else
        open_terminal()
    end
end })


local function go_to_terminal(index)
    local term_bufs = get_term_buffers()
    local cur_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(cur_win, term_bufs[index])
end


local group_id = vim.api.nvim_create_augroup('terminal_group', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = group_id,
    pattern = {
        'term://*',
        '\\[dap-terminal\\]*'
    },
    callback = function()
        local data = {
            buf = vim.fn.expand('<abuf>'),
            file = vim.fn.expand('<afile>'),
            match = vim.fn.expand('<amatch>'),
        }

        --[[ if vim.startswith(data.file, 'term://') then ]]
        --[[     vim.fn.execute("normal! i") ]]
        --[[ end ]]

        lib.buf_map(0, '', '<C-t>', '<Nop>', { callback = function()
            local win = get_win_with_term_buf()
            if win then
                vim.api.nvim_win_close(win, { force = false })
            else
                open_terminal()
            end
        end })

        lib.buf_map(0, 't', '<C-t>', '<Nop>', { callback = function()
            local win = get_win_with_term_buf()
            if win then
                vim.api.nvim_win_close(win, { force = false })
            else
                open_terminal()
            end
        end })

        lib.buf_map(0, '', '<Leader>1', '<Nop>', { callback = function() go_to_terminal(1) end })
        lib.buf_map(0, '', '<Leader>2', '<Nop>', { callback = function() go_to_terminal(2) end })
        lib.buf_map(0, '', '<Leader>3', '<Nop>', { callback = function() go_to_terminal(3) end })
        lib.buf_map(0, '', '<Leader>4', '<Nop>', { callback = function() go_to_terminal(4) end })
        lib.buf_map(0, '', '<Leader>5', '<Nop>', { callback = function() go_to_terminal(5) end })
        lib.buf_map(0, '', '<Leader>6', '<Nop>', { callback = function() go_to_terminal(6) end })
        lib.buf_map(0, '', '<Leader>7', '<Nop>', { callback = function() go_to_terminal(7) end })
        lib.buf_map(0, '', '<Leader>8', '<Nop>', { callback = function() go_to_terminal(8) end })
        lib.buf_map(0, '', '<Leader>9', '<Nop>', { callback = function() go_to_terminal(9) end })

        lib.buf_map(0, '', '<Leader>a', '<Nop>', { callback = function()
            vim.cmd('e term://zsh')
        end })

        local function close_term_buf()
            local cur_win = get_win_with_term_buf()
            local cur_buf = vim.api.nvim_win_get_buf(cur_win)

            local term_bufs = get_term_buffers()

            local filtered = U.list_filter(term_bufs, function(term_buf)
                return term_buf ~= cur_buf
            end)

            if #filtered == 0 then
                vim.cmd('bd!')
                return
            end

            vim.api.nvim_win_set_buf(cur_win, filtered[1])
            vim.cmd(cur_buf .. 'bd!')
            vim.api.nvim_win_set_option(cur_win, 'statusline', get_term_status_line())
        end

        lib.buf_map(0, '', '<C-q>', '<Nop>', { callback = function()
            close_term_buf()
        end })
        lib.buf_map(0, 't', '<C-q>', '<Nop>', { callback = function()
            close_term_buf()
        end })

        -- Easily navigate between terminal and other panes.
        lib.buf_map(0, '', '<C-h>', '<C-\\><C-n><C-w>h')
        lib.buf_map(0, '', '<C-j>', '<C-\\><C-n><C-w>j')
        lib.buf_map(0, '', '<C-k>', '<C-\\><C-n><C-w>k')
        lib.buf_map(0, '', '<C-l>', '<C-\\><C-n><C-w>l')
        lib.buf_map(0, 't', '<C-h>', '<C-\\><C-n><C-w>h')
        lib.buf_map(0, 't', '<C-j>', '<C-\\><C-n><C-w>j')
        lib.buf_map(0, 't', '<C-k>', '<C-\\><C-n><C-w>k')
        lib.buf_map(0, 't', '<C-l>', '<C-\\><C-n><C-w>l')

        -- Enter normal mode in terminal.
        lib.buf_map(0, 't', '<C-n>', '<C-\\><C-n>')


        local win = get_win_with_term_buf()
        if win ~= nil then
            local was_initial_height_set = vim.w.was_initial_height_set
            if was_initial_height_set == nil then
                vim.api.nvim_win_set_var(win, 'was_initial_height_set', 'true')
                vim.api.nvim_win_set_height(win, 10)
            end
        end

        vim.api.nvim_win_set_option(win, 'statusline', get_term_status_line())
    end
})
