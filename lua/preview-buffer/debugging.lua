local M = {}

M.setup = function(opts)
    M.opts = opts or {}
end

M.print = function(...)
    if M.opts.debug then
        -- print("preview-buffer: " .. ...)
        vim.notify("preview-buffer: " .. ...)
    end
end

M.warn = function(...)
    if M.opts.debug then
        -- warn("preview-buffer: " .. ...)
        vim.notify("preview-buffer: " .. ..., vim.log.levels.WARN)
    end
end

return M
