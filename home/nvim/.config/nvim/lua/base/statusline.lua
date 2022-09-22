local dap = require('dap')

local redrawn = 0

function _G.get_status_line()
    redrawn = redrawn + 1

    local file = '%f'
    local buf_num = '%n'

    local help_flag = '%h'
    local modified_flag = '%m'
    local readonly_flag = '%r'
    local preview_flag = '%p'
    local filetype_flag = '%y'
    local list_flag = '%q'

    local file_percentage = '%P'

    local dap_status = dap.status()

    local position = (function()
        local line_num = '%l'
        local col_num = '%c'
        local virtual_col_num = '%V'

        local group_start = '%-14('
        local group_end = '%)'

        return group_start .. line_num .. ',' .. col_num .. virtual_col_num .. group_end
    end)()

    local left = file .. ' ' .. help_flag .. modified_flag .. readonly_flag .. ' ' .. dap_status
    local alignment_separation_point = '%='
    local right = position .. ' ' .. redrawn .. ' ' .. file_percentage

    return left .. alignment_separation_point .. right
end

vim.cmd('set statusline=%!v:lua.get_status_line()')


local dap_events = {
    'event_terminated',
    'event_initialized',
    'event_stopped',
    'event_continued',
    'event_exited',
    'event_terminated',
    'event_thread',
    'event_output',
    'event_breakpoint',
    'event_module',
    'event_loadedSource',
    'event_process',
    'event_capabilities',
    'event_progressStart',
    'event_progressUpdate',
    'event_progressEnd',
    'event_invalidated',
    'event_memory', -- might be too many events
}

vim.tbl_map(function(event)
    dap.listeners.after[event]['redrawstatus'] = function()
        vim.cmd('redrawstatus')
    end
end, dap_events)

