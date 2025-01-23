local debugging = require("preview-buffer.debugging")

local M = {}

local current_preview_buffer = "NONE"

M.setup = function(opts)
    M.opts = opts or {}
    M.opts = vim.tbl_deep_extend("force", M.opts, opts)
    M.setup_autocmd()
end

--- Register the autocmds
M.setup_autocmd = function()
    vim.cmd [[
    augroup preview_buffer
        autocmd!
        autocmd BufAdd * lua require("preview-buffer.buffer").buffer_add_callback()
        autocmd BufModifiedSet * lua require("preview-buffer.buffer").buffer_modified_callback()
    ]]
    debugging.print("setup_autocmd")
end

--- Close the current preview buffer if it exists
--- Close it with the bufdelete function from snacks.nvim
local function close_preview_buffer()
    -- check if there is a current preview buffer
    if current_preview_buffer == "NONE" then
        return
    end

    debugging.print("closing preview buffer: " .. current_preview_buffer)

    -- close the buffer
    local number = vim.fn.bufnr(current_preview_buffer)
    if number ~= -1 then
        -- https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md
        Snacks.bufdelete.delete(number)
    end

    -- reset the current preview buffer
    current_preview_buffer = "NONE"
end

local function buffer_is_file(name)
    local number = vim.fn.bufnr(name)
    return vim.api.nvim_buf_get_option(number, 'buftype') == ""
end

--- Callback for when a buffer is added
--- Close the current preview buffer if it exists
--- Add the new buffer to the preview buffer
M.buffer_add_callback = function()
    -- get the name of the new buffer
    -- according to https://gist.github.com/dtr2300/2f867c2b6c051e946ef23f92bd9d1180
    local new_buffer_name = vim.fn.expand('<afile>')
    debugging.print("file being added: " .. new_buffer_name)

    -- check if the new buffer is a file
    if not buffer_is_file(new_buffer_name) then return end

    -- close the current preview buffer and replace it with the new buffer
    close_preview_buffer()
    M.buffer_enter_preview(new_buffer_name)
end

M.buffer_modified_callback = function()
    local modified_buffer_name = vim.fn.expand('<afile>')
    debugging.print("buffer_modified_callback: " .. modified_buffer_name)

    -- check if the modified buffer is a file
    if not buffer_is_file(modified_buffer_name) then return end

    -- exit preview if the modified buffer is the preview buffer
    if modified_buffer_name == current_preview_buffer then
        debugging.print("modified buffer is preview buffer")
        M.buffer_exit_preview()
    end
end

M.buffer_enter_preview = function(name)
    debugging.print("buffer_enter_preview: " .. name)
    current_preview_buffer = name
end

--- Let the preview buffer exit preview mode
M.buffer_exit_preview = function()
    debugging.print("buffer_exit_preview")
    -- local current_buffer_name = vim.api.nvim_buf_get_name(0)
    current_preview_buffer = "NONE"
end

--- Get the current preview buffer
M.current_preview_buffer = function()
    return current_preview_buffer
end

return M
