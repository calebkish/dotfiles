local U = {}

---@param table table
---@param filter_iter function
---@return table
U.tbl_filter = function(table, filter_iter)
  local out = {}

  for k, v in pairs(table) do
    if filter_iter(k, v, table) then out[k] = v end
  end

  return out
end

---@generic T
---@param list T[]
---@param list_iter fun(list_val: T, list: T[]): boolean
---@return T[]
U.list_filter = function(list, list_iter)
    local out = {}

    for _, v in ipairs(list) do
        if list_iter(v, list) then table.insert(out, v) end
    end

    return out
end

U.list_has_value = function(list, value)
    local filtered = U.list_filter(list, function(list_value)
        return list_value == value
    end)
    return #filtered ~= 0
end

---@param t table
---@return number
U.tbl_length = function(t)
    local count = 0
    for _, _ in pairs(t) do
        count = count + 1
    end
    return count
end

---@param file string
---@returns boolean
U.file_exists = function(file)
    local file_handle = io.open(file, 'r')
    if file_handle ~= nil then
        file_handle:close()
    end
    return file_handle ~= nil
end

---@param file string
---@param text string
---@param overwrite boolean
---@return boolean Whether file was successfully written to
U.write_file = function(file, text, overwrite)
    if U.file_exists(file) and not overwrite then
        return false
    end
    local file_handle = io.open(file, 'w')
    file_handle:write(text)
    file_handle:close()
    return true
end

---@param file string
---@return string
U.read_file = function(file)
    if not U.file_exists(file) then
        error('File doesn\'t exist')
    end
    local file_handle = io.open(file, 'r')
    local t = file_handle:read('*a')
    file_handle:close()
    return t
end

---Returns all items in `a` that are not in `b`
---@generic T
---@param a T[]
---@param b T[]
---@returns T[]
U.set_subtract = function(a, b)
    local c = {}

    for _, v in ipairs(a) do
        if not U.list_has_value(b, v) then
            table.insert(c, v)
        end
    end

    return c
end

return U
