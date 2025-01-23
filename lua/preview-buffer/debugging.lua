local M = {}

M.setup = function(opts)
    M.opts = opts or {}
end

M.print = function(...)
    if M.opts.debug then
        print("preview-buffer: " .. ...)
    end
end

M.warn = function(...)
    if M.opts.debug then
        warn("preview-buffer: " .. ...)
    end
end

return M
