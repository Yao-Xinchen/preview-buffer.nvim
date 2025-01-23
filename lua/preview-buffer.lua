local debugging = require("preview-buffer.debugging")
local buffer = require("preview-buffer.buffer")
local highlight = require("preview-buffer.highlight")

local M = {
    -- Default options
    opts = {
        debug = false, -- Print debug messages
        enable_preview_hl = false, -- Enable the preview highlight
    }
}

local function register_user_commands()
    vim.api.nvim_create_user_command(
        "BufferExitPreview",
        buffer.buffer_exit_preview,
        { desc = "Let the preview buffer exit preview mode" }
    )
end

M.setup = function(opts)
    opts = opts or {}
    M.opts = vim.tbl_deep_extend("force", M.opts, opts)

    -- setup submodules
    debugging.setup(M.opts)
    buffer.setup(M.opts)
    highlight.setup(M.opts)

    register_user_commands()
end

return M
