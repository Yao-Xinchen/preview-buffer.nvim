local debugging = require("preview-buffer.debugging")

local M = { opts = {}, }

local current_preview_buffer = "NONE"

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
    -- according to https://gist.github.com/dtr2300/2f867c2b6c051e946ef23f92bd9d1180
    local new_buffer_name = vim.fn.expand('<afile>')
    debugging.print("file being added: " .. new_buffer_name)
end

M.current_preview_buffer = function()
    return current_preview_buffer
end

return M
