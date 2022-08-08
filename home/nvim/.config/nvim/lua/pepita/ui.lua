local start_win, ex_buf, ex_win
local S = require('pepita.state')
local U = require('pepita.utils')

local UI = {}

local function set_explorer_mappings()
    local opts = { nowait = true, noremap = true, silent = true, buffer = ex_buf }
    vim.keymap.set('n', 'q', function() UI.close_explorer() end, opts)
    vim.keymap.set('n', 'v', function() UI.open_file_split('v') end, opts)
    vim.keymap.set('n', 's', function() UI.open_file_split() end, opts)
    vim.keymap.set('n', 'p', function() UI.preview_file() end, opts)
    vim.keymap.set('n', 't', function() UI.open_file_in_tab() end, opts)
end

local function create_explorer_win()
    -- We save handle to window from which we open the navigation
    start_win = vim.api.nvim_get_current_win()

    -- open a new vertical window on the far right
    vim.api.nvim_command('botright vnew')

    -- we save our explorer window handle...
    ex_win = vim.api.nvim_get_current_win()

    -- ...and its buffer handle
    ex_buf = vim.api.nvim_get_current_buf()

    -- Now we set some options for our buffer
    -- nofile prevents buffer as being in "modified" state so:
        -- We never get warnings when trying to quit w/o saving
    -- Also some plugins treat nofile buffers different:
        -- e.g. coc.nvim doesn't trigger autocompletion for these
    vim.api.nvim_buf_set_option(ex_buf, 'buftype', 'nofile')

    -- We do not need swapfile for this buffer
    vim.api.nvim_buf_set_option(ex_buf, 'swapfile', false)

    -- And we would rather prefer that this buffer will be destroyed when hidden
    vim.api.nvim_buf_set_option(ex_buf, 'bufhidden', 'wipe')

    -- It's not necessary but it is good practice to set custom filetype.
    -- This allows users to create their own autocommand or colorscheme on filetype
    -- and prevent collions with other plugins
    vim.api.nvim_buf_set_option(ex_buf, 'filetype', 'pepita')

    -- For better UX we will turn off line wrap and turn on current line highlight
    vim.api.nvim_win_set_option(ex_win, 'wrap', false)
    vim.api.nvim_win_set_option(ex_win, 'cursorline', true)

    set_explorer_mappings()
end

local function redraw_explorer()
    -- First we allow introducing new change to the buffer
    vim.api.nvim_buf_set_option(ex_buf, 'modifiable', true)

    -- Get the window height
    local items_count = vim.api.nvim_win_get_height(ex_win) - 1
    local list = {}
    local oldfiles = vim.api.nvim_get_vvar('oldfiles')

    -- Now we populate our list with X last items from oldfiles
    for i = #oldfiles, #oldfiles - items_count, -1 do
        pcall(function()
            -- We use built-in vim function fnamemodify to make path relative
            local path = vim.fn.fnamemodify(oldfiles[i], ':.')
            -- We iterate from end to start, so we should insert it
            -- at the end of results list to preserve order
            table.insert(list, #list + 1, path)
        end)
    end

    local recent = S.get_project(vim.loop.cwd()).recent

    local mapped = vim.tbl_map(function(file)
        return vim.fn.fnamemodify(file.file_path, ':.')
    end, recent)

    P(mapped)

    -- We apply results to buffer
    vim.api.nvim_buf_set_lines(ex_buf, 0, -1, false, list)
    -- And turn off editing
    vim.api.nvim_buf_set_option(ex_buf, 'modifiable', false)
end

function UI.open_file()
    -- we get path from line which user pushes enter on
    local path = vim.api.nvim_get_current_line()

    -- if the starting window exists
    if vim.api.nvim_win_is_valid(start_win) then
        -- we move to it
        vim.api.nvim_set_current_win(start_win)
        -- and edit chosen file
        vim.api.nvim_command('edit ' .. path)
    else
        -- if there is no starting window we create new from left side
        vim.api.nvim_command('leftabove vsplit ' .. path)
        -- and set it as our new starting window
        start_win = vim.api.nvim_get_current_win()
    end
end

function UI.close_explorer()
    if ex_win and vim.api.nvim_win_is_valid(ex_win) then
        vim.api.nvim_win_close(ex_win, true)
        ex_win = nil
    end
end

function UI.preview_file()
    UI.open_file() -- we open new file
    -- but in preview instead of closing navigation
    -- we focus back to it
    vim.api.nvim_set_current_win(ex_win)
end

function UI.open_file_split(axis)
    local path = vim.api.nvim_get_current_line()

    -- We still need to handle scenarios
    if vim.api.nvim_win_is_valid(start_win) then
        vim.api.nvim_set_current_win(start_win)
        -- We pass v in axis argument if we want vertical split
        -- or nothing/empty string otherwise
        vim.api.nvim_command(axis .. 'split ' .. path)
    else
        -- if there is no starting window we make new on left
        vim.api.nvim_command('leftabove ' .. axis .. 'split ' .. path)
        -- but in this case we do not need to set new starting window
        -- becaues splits always close navigation
    end

    UI.close_explorer()
end

function UI.open_file_in_tab()
    local path = vim.api.nvim_get_current_line()

    vim.api.nvim_command('tabnew ' .. path)
    UI.close_explorer()
end

function UI.open_explorer()
    local path = vim.loop.cwd()

    local proj = S.get_project(path)

    if proj == nil then
        local should_exit = false
        vim.ui.input({ prompt = 'Setup cwd with pepita? (Y/n): '}, function(input)
            local input_str = tostring(input)

            if input_str == 'n' or input_str == 'N' then
                should_exit = true
            end
        end)
        if should_exit then return end

        S.add_project()
    end

    if ex_win and vim.api.nvim_win_is_valid(ex_win) then
        vim.api.nvim_set_current_win(ex_win)
    else
        create_explorer_win()
    end

    redraw_explorer()
end


local opts = { nowait = true, noremap = true, silent = true, buffer = true }
vim.keymap.set('n', '<localleader>l', function() UI.open_explorer() end, opts)

return UI
