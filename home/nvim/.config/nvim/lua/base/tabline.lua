local lib = require('lib.lib')
local pepita = require('pepita.state')

-- function _G.get_file_name_of_buffer_of_current_window_on_tab(n)
--     local buffersOfWindowsOnTabPage = vim.fn.tabpagebuflist(n)
--     local numberOfCurrentWindowOnTabPage = vim.fn.tabpagewinnr(n)
--
--     local bufferOfCurrentWindowOnTabPage = buffersOfWindowsOnTabPage[numberOfCurrentWindowOnTabPage]
--     local bufferFilePath = vim.fn.bufname(bufferOfCurrentWindowOnTabPage)
--     local filePathTokens = vim.fn.split(bufferFilePath, '/')
--     return filePathTokens[#filePathTokens]
-- end

function _G.get_tab_line()
    local s = ''

    local proj = pepita.get_project(pepita.get_current_path()) or { recent = {} }

    local tabPagesAmount = vim.fn.tabpagenr('$')

    if #proj.recent == 0 and tabPagesAmount == 1 then
        vim.opt.showtabline = 1
        return
    end

    local curr_file_path = vim.fn.expand('%')
    local curr_file_path_tokens = vim.fn.split(curr_file_path, '/')
    local curr_file_name = curr_file_path_tokens[#curr_file_path_tokens]
    for index, file in ipairs(proj.recent) do
        local filePathTokens = vim.fn.split(file.file_path, '/')
        local name = filePathTokens[#filePathTokens]
        if name == curr_file_name then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end
        s = s .. index .. ' ' .. name .. ' '
    end

    s = s .. '%#TabLineFill#'

    local currentTabPageNumber = vim.fn.tabpagenr()
    if tabPagesAmount > 1 then
        s = s .. '%=%999('

        for i = 0, tabPagesAmount - 1, 1 do
            local tabPageNumber = i + 1

            if tabPageNumber == currentTabPageNumber then
                -- Set highlight group to TabLineSel
                s = s .. '%#TabLineSel#'
            else
                -- Set highlight group to TabLine
                s = s .. '%#TabLine#'
            end

            -- set the tab page number (for mouse clicks)
            s = s .. '%' .. tabPageNumber .. 'T'

            -- s = s .. ' %{v:lua.my_tab_label(' .. tabPageNumber .. ')} '
            s = s .. ' %{' .. tabPageNumber .. '} '
        end

        -- after the last tab fill with TabLineFill and reset tab page nr
        s = s .. '%#TabLineFill#%T'

        s = s .. '%)'
    end


    return s
end

vim.api.nvim_set_hl(0, 'TabLineSel', { bg = '#454545', fg = '#FFD7AF' })

vim.opt.showtabline = 2

vim.cmd('set tabline=%!v:lua.get_tab_line()')

lib.map('n', '<Leader>a', '<Nop>', { callback = function()
    vim.opt.showtabline = 2
    local proj_path = pepita.get_current_path()
    local file = vim.api.nvim_buf_get_name(0)
    pepita.add_recent_file(proj_path, file)
    vim.cmd('redrawtabline')
end })

lib.map('n', '<Leader>rf', '<Nop>', { callback = function()
    local count = vim.v.count
    local proj_path = pepita.get_current_path()
    if count == 0 then
        local file = vim.api.nvim_buf_get_name(0)
        pepita.remove_recent_file(proj_path, file)
    else
        pepita.remove_file_at_index(proj_path, count)
    end
    vim.cmd('redrawtabline')
end })


local function go_to_bookmark(num)
    local state = pepita.get_project(pepita.get_current_path())
    local file = state.recent[num]

    if file == nil then
        return
    end

    local curr_file = vim.api.nvim_buf_get_name(0)

    if file.file_path ~= curr_file then
        vim.cmd('edit ' .. file.file_path)
    end
end

lib.map('n', '<Leader>1', '<Nop>', { callback = function() go_to_bookmark(1) end })
lib.map('n', '<Leader>2', '<Nop>', { callback = function() go_to_bookmark(2) end })
lib.map('n', '<Leader>3', '<Nop>', { callback = function() go_to_bookmark(3) end })
lib.map('n', '<Leader>4', '<Nop>', { callback = function() go_to_bookmark(4) end })
lib.map('n', '<Leader>5', '<Nop>', { callback = function() go_to_bookmark(5) end })
lib.map('n', '<Leader>6', '<Nop>', { callback = function() go_to_bookmark(6) end })
lib.map('n', '<Leader>7', '<Nop>', { callback = function() go_to_bookmark(7) end })
lib.map('n', '<Leader>8', '<Nop>', { callback = function() go_to_bookmark(8) end })
lib.map('n', '<Leader>9', '<Nop>', { callback = function() go_to_bookmark(9) end })
