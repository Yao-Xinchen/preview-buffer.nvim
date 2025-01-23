local debugging = require("preview-buffer.debugging")

local M = { opts = {}, }

local current_preview_buffer = "NONE"

M.setup = function(opts)
    M.opts = opts or {}
    M.setup_autocmd()
end

--- Register the autocmds
M.setup_autocmd = function()
    vim.cmd [[
    augroup preview_buffer
        autocmd!
        autocmd BufAdd * lua require("preview-buffer.buffer").buffer_add_callback()
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
        Snacks.bufdelete.delete(number)
    end

    -- reset the current preview buffer
    current_preview_buffer = "NONE"
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
    local new_buffer_number = vim.fn.bufnr(new_buffer_name)
    if vim.api.nvim_buf_get_option(new_buffer_number, 'buftype') ~= "" then
        return -- do nothing if the new buffer is not a file
    end

    -- close the current preview buffer and replace it with the new buffer
    close_preview_buffer()
    current_preview_buffer = new_buffer_name
end

--- Let the preview buffer exit preview mode
M.buffer_exit_preview = function()
    local current_buffer_name = vim.api.nvim_buf_get_name(0)
        current_preview_buffer = "NONE"
end

--- Get the current preview buffer
M.current_preview_buffer = function()
    return current_preview_buffer
end

return M
