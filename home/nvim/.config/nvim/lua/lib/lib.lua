local lib = {}

function lib.map(mode, lhs, rhs, override_opts)
--    if type(rhs == 'function') then
--        vim.api.nvim_set_keymap(
--            mode,
--            lhs,
--            '<Nop>',
--            vim.tbl_extend(
--                'force',
--                { noremap = true, silent = true, callback = rhs },
--                override_opts or {}
--            )
--        )
--    else
        vim.api.nvim_set_keymap(
            mode,
            lhs,
            rhs,
            vim.tbl_extend(
                'force',
                { noremap = true, silent = true },
                override_opts or {}
            )
        )
--    end
end

function lib.buf_map(buffer, mode, lhs, rhs, override_opts)
--    if type(rhs) == 'function' then
--        vim.api.nvim_buf_set_keymap(
--            buffer,
--            mode,
--            lhs,
--            '<Nop>',
--            vim.tbl_extend(
--                'force',
--                { noremap = true, silent = true, callback = rhs },
--                override_opts or {}
--            )
--        )
--    else
        vim.api.nvim_buf_set_keymap(
            buffer,
            mode,
            lhs,
            rhs,
            vim.tbl_extend(
                'force',
                { noremap = true, silent = true },
                override_opts or {}
            )
        )
--    end
end

return lib

