local enable, highlights = pcall(require, "bufferline.highlights")
local debugging = require("preview-buffer.debugging")

local M = {
    enable = enable,
    opts = {
        preview_hl = {
            underline = true,
        }
    }
}

local function prepare_hl()
    if not M.enable then return end

    debugging.print("prepare_hl")

    -- M.preview_hl = highlights.get_highlight_group("BufferCurrent")
    M.preview_hl = vim.tbl_deep_extend("force", M.preview_hl, M.opts.preview_hl)
end

M.setup = function(opts)
    M.opts = opts or {}
    M.opts = vim.tbl_deep_extend("force", M.opts, opts)

    M.enable = M.opts.enable_preview_hl and M.enable

    if M.enable then
        debugging.print("highlight enabled")
    end

    prepare_hl()
end

M.set_preview_hl = function(buffer_id)
    if not M.enable then return end
    -- TODO: set the highlight for the buffer
end

return M
