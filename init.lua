local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.o.background = 'dark'
vim.opt.listchars = { extends = '.', precedes = '|', nbsp = '_', tab = '└─┘' }
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.clipboard = "unnamed,unnamedplus"
-- vim.opt.statuscolumn = '%=%{v:lnum}│%{v:relnum}'

-- This should probably not go into the repo, as it's not universally usefull
vim.filetype.add({
    filename = {
        ['inventory'] = 'dosini',
    }
})

-- Automatically close terminal Buffers when their Process is done
vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        vim.cmd("bdelete")
    end
})

-- vim.api.nvim_create_autocmd('User', {
--     pattern = 'MiniFilesWindowOpen',
--     callback = function(args)
--         local win_id = args.data.win_id
--
--         -- Customize window-local settings
--         vim.wo[win_id].winblend = 10
--         vim.api.nvim_win_set_config(win_id, { border = 'rounded' })
--     end,
-- })

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = {},
    checker = { enabled = false }, -- automatically check for plugin updates
    change_detection = {
        enabled = false,
    },
})

    require("highlights")
    require("keybinds")
    vim.cmd('colorscheme domscheme')
