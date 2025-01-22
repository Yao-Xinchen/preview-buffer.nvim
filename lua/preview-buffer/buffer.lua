local debugging = require("preview-buffer.debugging")

local M = {}

M.buffer_enter_preview = function()
    debugging.print("buffer_enter_preview")
end

return M
