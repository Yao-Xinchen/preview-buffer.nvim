local debugging = require("preview-buffer.debugging")

local M = { opts = {}, }

M.setup = function(opts)
    M.opts = opts or {}
    M.setup_autocmd()
end

M.setup_autocmd = function()
    vim.cmd [[
    augroup preview_buffer
        autocmd!
        autocmd BufAdd * lua require("preview-buffer.buffer").buffer_add_callback()
    ]]
    debugging.print("setup_autocmd")
end

M.buffer_add_callback = function()
    if M.buffer_is_file() then
        debugging.print("new file buffer")
    end
end

M.buffer_is_file = function()
    return vim.bo.buftype == ""
end

return M
