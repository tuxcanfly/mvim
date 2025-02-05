-- Overwrite some Highlight Groups to add Italic Fonts

local function mod_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name, link = true })
    if is_ok then
        for k, v in pairs(opts) do hl_def[k] = v end
        vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    group = vim.api.nvim_create_augroup('Color', {}),
    pattern = "*",
    callback = function()
        -- Comments
        mod_hl("Comment", { italic = true })
        -- Current Tab
        mod_hl("MiniTablineVisible", { italic = true })
        mod_hl("MiniTablineCurrent", { italic = true })
        mod_hl("MiniTablineModifiedCurrent", { italic = true })
        -- Statusline Mode
        mod_hl("MiniStatuslineModeNormal", { italic = true })
        mod_hl("MiniStatuslineModeInsert", { italic = true })
        mod_hl("MiniStatuslineModeVisual", { italic = true })
        mod_hl("MiniStatuslineModeReplace", { italic = true })
        mod_hl("MiniStatuslineModeOther", { italic = true })
        -- Mattern Annotations
        mod_hl("MiniHipatternsNote", { italic = true })
        -- Ansible Hosts Files
        mod_hl("hostsFirstWord", {link = 'Normal'})
        mod_hl("hostsHeaderSpecials", { link = "Comment" })
        -- Custom for Statusline
        mod_hl("MvimTestgroup", {bg="fg", fg="bg"})
    end
})
