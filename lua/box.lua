function box_draw()
    local top = "╔════════════════════════════════════════════════════════════════════════════════╗"
    local side = "║"
    local bottom = "╚════════════════════════════════════════════════════════════════════════════════╝"

    local _, start_line, _, _ = unpack(vim.fn.getpos("'<"))
    local _, end_line, _, _ = unpack(vim.fn.getpos("'>"))
    start_line = start_line - 1
    end_line = end_line - 1

    -- Iterate through each line in the selection
    for line = start_line, end_line do
        -- Get the current line content
        local line_content = vim.fn.getline(line + 1)
        -- Prepend the character
        vim.fn.setline(line + 1, side .. line_content .. side)
        vim.api.nvim_buf_set_lines(0, start_line, start_line, false, { "Test" })
    end
end

vim.keymap.set("v", "<leader>cb", function() box_draw() end, {desc="Comment Box"})
