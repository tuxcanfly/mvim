-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    vim.g.mapleader = " "
    vim.opt.background = 'dark'
    vim.opt.listchars = { extends = '.', precedes = '|', nbsp = '_', tab = '└─┘' }
    vim.opt.smartindent = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.expandtab = true
    vim.opt.relativenumber = true
    vim.opt.scrolloff = 10
    vim.opt.clipboard = "unnamed,unnamedplus"
    -- This is needed for mini.animate to work with mouse scrolling
    vim.opt.mousescroll = 'ver:1,hor:1'
    -- vim.opt.statuscolumn = '%=%{v:lnum}│%{v:relnum}'
    vim.cmd('colorscheme randomhue')
end)

later(function() require('mini.ai').setup() end)
later(function() require('mini.align').setup() end)
later(function()
    local animate = require('mini.animate')
    animate.setup {
        scroll = {
            -- Disable Scroll Animations, as the can interfer with mouse Scrolling
            enable = true,
        },
        cursor = {
            timing = animate.gen_timing.cubic({ duration = 50, unit = 'total' })
        },
    }
end)
-- Disabled Here. This is called directly from our Colorscheme in the colors/ folder
-- You can enable this by uncommenting.
-- We provide a basic Catppuccin Colorscheme here
-- later(function()
--     require('mini.base16').setup({
--         palette = {
--             base00 = '#1e1e2e',
--             base01 = '#181825',
--             base02 = '#313244',
--             base03 = '#45475a',
--             base04 = '#585b70',
--             base05 = '#cdd6f4',
--             base06 = '#f5e0dc',
--             base07 = '#b4befe',
--             base08 = '#f38ba8',
--             base09 = '#fab387',
--             base0A = '#f9e2af',
--             base0B = '#a6e3a1',
--             base0C = '#94e2d5',
--             base0D = '#89b4fa',
--             base0E = '#cba6f7',
--             base0F = '#f2cdcd'
--         }
--     })
-- end)
later(function()
    require('mini.basics').setup({
        options = {
            extra_ui = true,
            win_borders = 'rounded',
        },
        mappings = {
            windows = true,
        }
    })
end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.bufremove').setup() end)
later(function()
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
            { mode = 'n', keys = '<Leader>b', desc = ' Buffer' },
            { mode = 'n', keys = '<Leader>f', desc = ' Find' },
            { mode = 'n', keys = '<Leader>g', desc = '󰊢 Git' },
            { mode = 'n', keys = '<Leader>i', desc = '󰏪 Insert' },
            { mode = 'n', keys = '<Leader>l', desc = '󰘦 LSP' },
            { mode = 'n', keys = '<Leader>q', desc = ' NVim' },
            { mode = 'n', keys = '<Leader>s', desc = '󰆓 Session' },
            { mode = 'n', keys = '<Leader>u', desc = '󰔃 UI' },
            { mode = 'n', keys = '<Leader>w', desc = ' Window' },
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
end)
later(function() require('mini.colors').setup() end)
later(function() require('mini.comment').setup() end)
later(function()
    require('mini.completion').setup({
        window = {
            info = { border = 'rounded' },
            signature = { border = 'rounded' },
        }
    })
end)
later(function() require('mini.cursorword').setup() end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.doc').setup() end)
later(function() require('mini.extra').setup() end)
later(function()
    require('mini.files').setup({
        windows = {
            preview = true,
            width_preview = 80,
        }
    })
end)
later(function() require('mini.fuzzy').setup() end)
now(function()
    local hipatterns = require('mini.hipatterns')

    local censor_extmark_opts = function(_, match, _)
        local mask = string.rep('*', vim.fn.strchars(match))
        return {
            virt_text = { { mask, 'Comment' } },
            virt_text_pos = 'overlay',
            priority = 200,
            right_gravity = false,
        }
    end

    local password_table = {
        pattern = {
            'password: ()%S+()',
            'password_usr: ()%S+()',
        },
        group = '',
        extmark_opts = censor_extmark_opts
    }

    hipatterns.setup({
        highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
            hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
            todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
            note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

            -- Cloaking Passwords
            pw        = password_table,

            -- Highlight hex color strings (`#rrggbb`) using that color
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })

    vim.keymap.set("n", "<leader>up", function()
        if next(hipatterns.config.highlighters.pw) == nil then
            hipatterns.config.highlighters.pw = password_table
        else
            hipatterns.config.highlighters.pw = {}
        end
        vim.cmd('edit')
    end, { desc = 'Toggle Password Cloaking' })
end)
-- We disable this, as we use our own Colorscheme through mini.colors
-- You can enable this by uncommenting
-- We Provide a Modus Vivendi inspired setup here
-- later(function() require('mini.hues').setup({ background = '#0d0e1c', foreground = '#feacd0' }) end)
later(function()
    require('mini.indentscope').setup({
        draw = {
            animation = function() return 1 end,
        },
        symbol = "│"
    })
end)
later(function() require('mini.jump').setup() end)
later(function() require('mini.jump2d').setup() end)
later(function() require('mini.map').setup() end)
later(function() require('mini.misc').setup() end)
later(function() require('mini.move').setup({}) end)
later(function() require('mini.notify').setup({
    lsp_progress = {
        enable = true,
        duration_last = 200,
    }
}) end)
later(function() require('mini.operators').setup() end)
later(function() require('mini.pairs').setup() end)
later(function()
    local win_config = function()
        height = math.floor(0.618 * vim.o.lines)
        width = math.floor(0.618 * vim.o.columns)
        return {
            anchor = 'NW',
            height = height,
            width = width,
            border = 'rounded',
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
        }
    end
    require('mini.pick').setup({
        mappings = {
            choose_in_vsplit = '<C-CR>',
        },
        options = {
            use_cache = true
        },
        window = {
            config = win_config
        }
    })
end)
now(function()
    require('mini.sessions').setup({
        autowrite = true
    })
end)
later(function() require('mini.splitjoin').setup() end)
now(function()
    require('mini.starter').setup({
        autoopen = true,
        items = {
            require('mini.starter').sections.builtin_actions(),
            require('mini.starter').sections.recent_files(5, false),
            require('mini.starter').sections.recent_files(5, true),
            require('mini.starter').sections.sessions(5, true),
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
    })
end)
later(function()
    require('mini.statusline').setup({
        use_icons = true,
    })
end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.tabline').setup() end)
later(function() require('mini.trailspace').setup() end)
later(function() require('mini.visits').setup() end)

-- later(function()
--     add('VonHeikemen/lsp-zero.nvim')
--     require('lsp-zero')
-- end)

later(function()
    add({
        source = 'neovim/nvim-lspconfig',
        depends = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim'
        }
    })
    require('mason').setup()
    require('mason-lspconfig').setup()
    require('lspconfig').lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    disable = { "lowercase-global", "undefined-global" }
                },
            }
        }
    }
    require('lspconfig').ansiblels.setup {
        -- filetypes = {
        --     "yaml"
        -- }
    }
    -- require('lspconfig').yamlls.setup {}
end)

require("autocmds")
require("filetypes")
require("highlights")
require("keybinds")
