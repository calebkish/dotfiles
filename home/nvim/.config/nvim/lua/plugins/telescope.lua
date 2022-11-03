local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

local lib = require('lib.lib')

local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')
local actions = require('telescope.actions')

telescope.setup {
    defaults = {
        file_sorter = sorters.get_fzy_sorter,
        prompt_prefix = ' > ',
        color_devicons = true,

        file_previewer   = previewers.vim_buffer_cat.new,
        grep_previewer   = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
telescope.load_extension('fzy_native')

-- lib.map('n', '<C-p>', ':lua require(\'telescope.builtin\').git_files()<CR>')

lib.map('n', '<C-p>', '<Cmd>lua require(\'telescope.builtin\').find_files()<CR>')

lib.map('n', '<Leader>fg', '<Cmd>lua require(\'telescope.builtin\').live_grep()<CR>')
-- lib.map('n', '<Leader>fb', '<Cmd>lua require(\'telescope.builtin\').buffers()<CR>')
-- lib.map('n', '<Leader>fh', '<Cmd>lua require(\'telescope.builtin\').help_tags()<CR>')
