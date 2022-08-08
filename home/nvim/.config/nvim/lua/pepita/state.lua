local U = require('pepita.utils')
local Job = require('plenary.job')



local PROJ_FILE_PATH = vim.fn.stdpath('data') .. '/pepita.json'

math.randomseed(os.time())

local mappings = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'y', 'x', 'z' }


---@class pep.ProjectFile
---@field file_path string
---@field mapping string
---@field times_accessed number

---@class pep.Project
---@field recent pep.ProjectFile[]

---@alias pep.Projects table<string, pep.Project>




---@return pep.Projects
local function get_projects()
    local decode_ok, result = pcall(vim.fn.json_decode, U.read_file(PROJ_FILE_PATH))
    return decode_ok and result or {}
end

---@param projects pep.Projects
local function set_projects(projects)
    local text = vim.fn.json_encode(projects) .. '\n'
    U.write_file(PROJ_FILE_PATH, text, true)
end



local M = {}

---@param project_path string
function M.get_project(project_path)
    local projs = get_projects()
    return projs[project_path]
end

---@param project_path string | nil
---@param file_to_add string
---@return table<string, string> of new recent files and their mappings
function M.add_recent_file(project_path, file_to_add)
    if not vim.startswith(file_to_add, project_path) then
        error('The file ' .. file_to_add .. ' is not in project folder ' .. project_path)
    end

    if not U.file_exists(file_to_add) then
        error('The file ' .. file_to_add .. ' does not exist')
    end

    local projs = get_projects()

    if projs[project_path] == nil then
        M.add_project()
        projs = get_projects()
        -- error('Could not find project for path ' .. project_path)
    end

    if projs[project_path].recent == nil then
        projs[project_path].recent = {}
    end

    local existing_file_entries = U.list_filter(projs[project_path].recent, function(file)
        return file.file_path == file_to_add
    end)

    if #existing_file_entries ~= 0 then
        -- Return early so we don't overwrite file entry
        return projs[project_path].recent
    end

    local claimed_mappings = vim.tbl_map(function(v)
        return v.mapping
    end, projs[project_path].recent)

    local unclaimed_mappings = U.set_subtract(mappings, claimed_mappings)

    if #unclaimed_mappings == 0 then
        error('No more mappings available')
    end

    local mapping_to_claim = unclaimed_mappings[math.random(#unclaimed_mappings)]

    table.insert(projs[project_path].recent, {
        file_path = file_to_add,
        mapping = mapping_to_claim,
        times_accessed = 0
    })

    set_projects(projs)

    return projs[project_path].recent
end


---@param project_path string
---@param file_to_remove string
---@return table<string, string> of filtered recent files and their mappings
function M.remove_recent_file(project_path, file_to_remove)
    if not vim.startswith(file_to_remove, project_path) then
        error('The file ' .. file_to_remove .. ' is not in project folder ' .. project_path)
    end

    local projs = get_projects()
    if projs[project_path] == nil then
        error('Could not find project for path ' .. project_path)
    end

    if projs[project_path].recent == nil then
        projs[project_path].recent = {}
        return projs[project_path].recent
    end

    -- local recent = projs[project_path].recent

    local filtered = U.list_filter(projs[project_path].recent, function(file)
        return file.file_path ~= file_to_remove
    end)

    if U.tbl_length(filtered) == U.tbl_length(projs[project_path].recent) then
        error('Could not find ' .. file_to_remove .. ' in the project\'s recent files')
    end

    projs[project_path].recent = filtered

    set_projects(projs)

    return projs[project_path].recent
end

function M.remove_file_at_index(project_path, index)
    local projs = get_projects()
    if projs[project_path] == nil then
        error('Could not find project for path ' .. project_path)
    end

    if projs[project_path].recent == nil then
        projs[project_path].recent = {}
        return projs[project_path].recent
    end

    local file_at_index = projs[project_path].recent[index].file_path

    if file_at_index == nil then
        error('Could not find file at index' .. index)
    end

    return M.remove_recent_file(project_path, file_at_index)
end


-- function M.setup_global_autocmds()
--     local group = vim.api.nvim_create_augroup("PepitaGroup", { clear = true })
--     vim.api.nvim_create_autocmd("BufEnter", { callback = function()
--
--     end, group = group })
-- end


function M.add_project()
    if not U.file_exists(PROJ_FILE_PATH) then
        Job:new({ command = 'mkdir', args = { '-p', PROJ_FILE_PATH } })
        set_projects({})
    end

    local path = M.get_current_path()

    local projs = get_projects()

    if projs[path] then
        error('Project already has an entry')
    end

    projs[path] = {
        recent = {},
    }
    set_projects(projs)
end

function M.get_current_path()
    local out, err = '', ''
    Job:new({
        command = 'git',
        args = { 'rev-parse', '--show-toplevel'},
        on_stdout = function(_, data)
            out = out .. data
        end,
        on_stderr = function(_, data)
            err = err .. data
        end
    }):sync()


    -- Use the cwd by default
    local path = vim.loop.cwd()
    if #out ~= 0 then
        -- Use git project dir if we are in it or a subdir of it
        path = out
    end

    return path
end

-- local thing = M.add_recent_file('/home/caleb/.config/nvim/lua/base/options.lua')
-- P(thing)

-- local thing2 = M.remove_recent_file(path, '/home/caleb/.config/nvim/lua/base/options.lua')
-- P(thing2)

--[[ TODO

- Display files w/ mappings in explorer

- Initialize explorer file mappings

--]]


return M
