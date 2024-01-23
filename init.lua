local MvimFont = "JetBrainsMono Nerd Font"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local keymap = vim.keymap.set

function increase_font()
    local current_size = tonumber(string.match(vim.o.guifont, 'h(%d+)'))
    if current_size then
        local new_size = current_size + 1
        vim.o.guifont = string.gsub(vim.o.guifont, 'h%d+', 'h' .. new_size)
    end
end

function decrease_font()
    local current_size = tonumber(string.match(vim.o.guifont, 'h(%d+)'))
    if current_size then
        local new_size = current_size - 1
        if new_size >= 5 then -- To prevent the font size from becoming too small
            vim.o.guifont = string.gsub(vim.o.guifont, 'h%d+', 'h' .. new_size)
        end
    end
end

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

-- General Vim Things
keymap("n", "<leader>wq", "<cmd>q<cr>", { noremap = true, silent = true, desc = 'Quit' })
keymap("n", "<leader>ul", "<cmd>Lazy<cr>", { noremap = true, silent = true, desc = 'Lazy' })

-- Finding Stuff
keymap("n", "<leader>fs", "<cmd>lua MiniPick.builtin.files()<cr>", { noremap = true, silent = true, desc = 'Find File' })
keymap("n", "<leader>e", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
    { noremap = true, silent = true, desc = 'Find Manualy' })
keymap("n", "<leader><space>", "<cmd>lua MiniPick.builtin.buffers()<cr>",
    { noremap = true, silent = true, desc = 'Find Buffer' })
keymap("n", "<leader>fg", "<cmd>lua MiniPick.builtin.grep_live()<cr>",
    { noremap = true, silent = true, desc = 'Find String' })
keymap("n", "<leader>fh", "<cmd>lua MiniPick.builtin.help()<cr>", { noremap = true, silent = true, desc = 'Find Help' })
keymap("n", "<leader>fc", function()
        local init_scheme = vim.g.colors_name
        local new_scheme = require('mini.pick').start({
            source = {
                items = vim.fn.getcompletion("", "color"),
                preview = function(_, item)
                    pcall(vim.cmd, 'colorscheme ' .. item)
                end,
                choose = function(item)
                    pcall(vim.cmd, 'colorscheme ' .. item)
                end
            },
            mappings = {
                preview = {
                    char = '<C-p>',
                    func = function()
                        local item = require('mini.pick').get_picker_matches()
                        pcall(vim.cmd, 'colorscheme ' .. item.current) end
                }
            }
        })
        if new_scheme == nil then pcall(vim.cmd, 'colorscheme ' .. init_scheme) end
    end,
    { noremap = true, silent = true, desc = 'Change Colorscheme' })

-- Session Related Keymaps
keymap("n", "<leader>ss", "<cmd>lua MiniSessions.select()<cr>",
    { noremap = true, silent = true, desc = 'Switch Session' })
keymap("n", "<leader>sw", "<cmd>lua MiniSessions.write()<cr>", { noremap = true, silent = true, desc = 'Save Session' })

-- Buffer Related Keymaps
keymap("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, silent = true, desc = 'Close Buffer' })
keymap("n", "<leader>bf", "<cmd>lua vim.lsp.buf.format()<cr>", { noremap = true, silent = true, desc = 'Format Buffer' })
keymap("n", "<C-l>", "<cmd>bnext<cr>", { silent = true, desc = 'Next Buffer' })
keymap("n", "<C-h>", "<cmd>bprevious<cr>", { silent = true, desc = 'Previous Buffer' })

-- Git Related Keymaps
keymap("n", "<leader>gg", "<cmd>terminal lazygit<cr>", { noremap = true, silent = true, desc = 'Lazygit' })
keymap("n", "<leader>gp", "<cmd>terminal git pull<cr>", { noremap = true, silent = true, desc = 'Git Push' })
keymap("n", "<leader>gs", "<cmd>terminal git push<cr>", { noremap = true, silent = true, desc = 'Git Pull' })
keymap("n", "<leader>ga", "<cmd>terminal git add .<cr>", { noremap = true, silent = true, desc = 'Git Add All' })
keymap("n", "<leader>gc", '<cmd>terminal git commit -m "Autocommit from MVIM"<cr>',
    { noremap = true, silent = true, desc = 'Git Autocommit' })

-- LSP Keymaps
keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>",
    { noremap = true, silent = true, desc = 'Go To Definition' })
keymap("n", "<leader>ls", "<cmd>Pick lsp scope='document_symbol'<cr>",
    { noremap = true, silent = true, desc = 'Show all Symbols' })
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true, desc = 'Rename This' })
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",
    { noremap = true, silent = true, desc = 'Code Actions' })

-- UI Related Keymaps
-- Window Navigation
keymap("n", "<leader>wl", "<cmd>wincmd l<cr>", { noremap = true, silent = true, desc = 'Focus Left' })
keymap("n", "<leader>wk", "<cmd>wincmd k<cr>", { noremap = true, silent = true, desc = 'Focus Up' })
keymap("n", "<leader>wj", "<cmd>wincmd j<cr>", { noremap = true, silent = true, desc = 'Focus Down' })
keymap("n", "<leader>wh", "<cmd>wincmd h<cr>", { noremap = true, silent = true, desc = 'Focus Right' })
keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { noremap = true, silent = true, desc = 'Focus Right' })

-- Change Colorscheme
keymap("n", "<leader>ud", "<cmd>set background=dark<cr>", { noremap = true, silent = true, desc = 'Dark Background' })
keymap("n", "<leader>ub", "<cmd>set background=light<cr>", { noremap = true, silent = true, desc = 'Light Backround' })
keymap("n", "<leader>um", "<cmd>lua MiniMap.open()<cr>", { noremap = true, silent = true, desc = 'Mini Map' })

-- Font Size and "Presentation Mode"
keymap("n", "<leader>uf1", "<cmd>GuiFont! " .. MvimFont .. ":h10<cr>",
    { noremap = true, silent = true, desc = 'Font Size 10' })
keymap("n", "<leader>uf2", "<cmd>GuiFont! " .. MvimFont .. ":h12<cr>",
    { noremap = true, silent = true, desc = 'Font Size 12' })
keymap("n", "<leader>uf3", "<cmd>GuiFont! " .. MvimFont .. ":h14<cr>",
    { noremap = true, silent = true, desc = 'Font Size 14' })
keymap("n", "<leader>ufp", "<cmd>GuiFont! " .. MvimFont .. ":h20<cr>",
    { noremap = true, silent = true, desc = 'Font Size 20' })
keymap("n", "<leader>ufk", ":lua increase_font()<CR>", { noremap = true, silent = true, desc = 'Increase Font Size' })
keymap("n", "<leader>ufj", ":lua decrease_font()<CR>", { noremap = true, silent = true, desc = 'Decrease Font Size' })


-- Completion Navigaiont
-- keymap('i', '<Down>', [[pumvisible() ? "<C-o>j" : "\<Down>"]], { expr = true, noremap = true })
-- keymap('i', '<Up>', [[pumvisible() ? "<C-o>k" : "\<Up>"]], { expr = true, noremap = true })

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

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
        local win_id = args.data.win_id

        -- Customize window-local settings
        vim.wo[win_id].winblend = 10
        vim.api.nvim_win_set_config(win_id, { border = 'rounded' })
    end,
})

require("lazy").setup({
    'equalsraf/neovim-gui-shim',
    {
        'craftzdog/solarized-osaka.nvim',
        config = function()
            require("solarized-osaka").setup({
                transparent = false, -- Enable this to disable setting the background color
            })
        end
    },
    { "catppuccin/nvim",  name = "catppuccin", priority = 1000 },
    'folke/tokyonight.nvim',
    'nyoom-engineering/oxocarbon.nvim',
    'navarasu/onedark.nvim',
    'rebelot/kanagawa.nvim',
    'sainnhe/everforest',
    'kdheepak/monochrome.nvim',
    { 'rose-pine/neovim', name = 'rose-pine' },
    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            -- require{'mini.ai'}.setup()
            -- require{'mini.align'}.setup()
            -- require{'mini.animate'}.setup()
            -- require{'mini.base16'}.setup()
            require('mini.basics').setup({
                options = {
                    extra_ui = true,
                    win_borders = 'double',
                },
                mappings = {
                    windows = true,
                }
            })
            require('mini.bracketed').setup()
            require('mini.bufremove').setup()
            require('mini.clue').setup({
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },
                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    { mode = 'n', keys = '<Leader>f', desc = 'Find' },
                    { mode = 'n', keys = '<Leader>l', desc = 'LSP' },
                    { mode = 'n', keys = '<Leader>w', desc = 'Window' },
                    { mode = 'n', keys = '<Leader>s', desc = 'Session' },
                    { mode = 'n', keys = '<Leader>b', desc = 'Buffer' },
                    { mode = 'n', keys = '<Leader>g', desc = 'Git' },
                    { mode = 'n', keys = '<Leader>u', desc = 'UI' },
                    { mode = 'n', keys = '<Leader>q', desc = 'NVim' },
                    function() MiniClue.gen_clues.g() end,
                    function() MiniClue.gen_clues.builtin_completion() end,
                    function() MiniClue.gen_clues.marks() end,
                    function() MiniClue.gen_clues.registers() end,
                    function() MiniClue.gen_clues.windows() end,
                    function() MiniClue.gen_clues.z() end,
                },
                window = {
                    delay = 300
                }
            })
            -- require('mini.colors').setup()
            require('mini.comment').setup()
            require('mini.completion').setup({
                window = {
                    info = { border = 'rounded' },
                    signature = { border = 'rounded' },
                }
            })
            require('mini.cursorword').setup()
            -- require('mini.doc').setup()
            require('mini.extra').setup()
            require('mini.files').setup({
                windows = {
                    preview = true,
                }
            })
            require('mini.fuzzy').setup()
            require('mini.hipatterns').setup()
            -- require('mini.hues').setup({ background = '#282828', foreground = '#EBDBB2' })
            require('mini.indentscope').setup({
                draw = {
                    animation = function(s, n) return 5 end,
                },
                symbol = "│"
            })
            require('mini.jump').setup()
            require('mini.jump2d').setup()
            require('mini.map').setup()
            require('mini.misc').setup()
            require('mini.move').setup()
            require('mini.notify').setup()
            require('mini.operators').setup()
            require('mini.pairs').setup()
            require('mini.pick').setup({
                mappings = {
                    choose_in_vsplit = '<C-CR>',
                },
                options = {
                    use_cache = true
                },
                window = {
                    config = {
                        border = 'rounded'
                    },
                }
            })
            require('mini.sessions').setup({
                autowrite = true
            })
            require('mini.splitjoin').setup()
            require('mini.starter').setup({

                items = {
                    require('mini.starter').sections.builtin_actions(),
                    require('mini.starter').sections.recent_files(5, false),
                    require('mini.starter').sections.recent_files(5, true),
                    require('mini.starter').sections.sessions(5, true),
                    { name = 'Lazy', action = 'Lazy', section = 'Lazy' }
                },
                header = [[
███╗   ███╗██╗   ██╗██╗███╗   ███╗
████╗ ████║██║   ██║██║████╗ ████║
██╔████╔██║██║   ██║██║██╔████╔██║
██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
██║     ██║  ╚═══╝  ╚═╝██║     ██║
██║     ██║ini      nvi██║     ██║
╚═╝     ╚═╝            ╚═╝     ╚═╝]],
                footer = footer_n_seconds
            })
            require('mini.statusline').setup({
                use_icons = true,
            })
            local animate = require('mini.animate')
            animate.setup {
                scroll = {
                    -- Disable Scroll Animations, as the can interfer with mouse Scrolling
                    enable = false,
                },
                cursor = {
                    timing = animate.gen_timing.cubic({ duration = 50, unit = 'total' })
                },
            }
            require('mini.surround').setup()
            require('mini.tabline').setup()
            -- require('mini.test').setup()
            require('mini.trailspace').setup()
            require('mini.visits').setup()
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    -- {
    --   'hrsh7th/nvim-cmp',
    --   event = 'InsertEnter',
    --   dependencies = {
    --     {'L3MON4D3/LuaSnip'},
    --   },
    --   config = function()
    --     -- Here is where you configure the autocompletion settings.
    --     local lsp_zero = require('lsp-zero')
    --     lsp_zero.extend_cmp()
    --
    --     -- And you can configure cmp even more, if you want to.
    --     local cmp = require('cmp')
    --     local cmp_action = lsp_zero.cmp_action()
    --
    --     cmp.setup({
    --       formatting = lsp_zero.cmp_format(),
    --       mapping = cmp.mapping.preset.insert({
    --         ['<C-Space>'] = cmp.mapping.complete(),
    --         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --         ['<C-d>'] = cmp.mapping.scroll_docs(4),
    --         ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    --         ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    --       })
    --     })
    --   end
    -- },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls' },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        -- local lua_opts = lsp_zero.nvim_lua_ls()
                        -- require('lspconfig').lua_ls.setup(lua_opts)
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        disable = { "lowercase-global", "undefined-global" }
                                    },
                                    hint = {
                                        enable = false,
                                        arrayIndex = "Auto",
                                        await = true,
                                        paramName = "All",
                                        paramType = true,
                                        semicolon = "SameLine",
                                        setType = false,
                                    },
                                },
                            },
                        })
                    end,
                }
            })
        end
    }
})
vim.cmd('colorscheme kanagawa')
