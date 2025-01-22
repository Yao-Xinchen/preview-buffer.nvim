local buffer = require("preview-buffer.buffer")
local appearance = require("preview-buffer.appearance")
local debugging = require("preview-buffer.debugging")

local M = {
    -- Default options
    opts = {
        debug = true -- Print debug messages
    }
}

M.setup = function(opts)
    opts = opts or {}
    M.opts = vim.tbl_deep_extend("force", M.opts, opts)
    debugging.setup(M.opts)
    -- buffer.setup(M.opts)
    -- appearance.setup(M.opts)
    debugging.print("setup preview-buffer")
end

return M
