local M = {}

M.setup = function(opts)
    M.opts = opts or {}
end

M.print = function(...)
    if M.opts.debug then
        vim.notify("preview-buffer: " .. ...)
    end
end

return M
