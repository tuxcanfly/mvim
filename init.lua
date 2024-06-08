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
    vim.g.mapleader      = "\\"
    vim.o.backup         = false
    vim.o.writebackup    = false
    vim.o.undofile       = true
    vim.o.mouse          = 'a'
    vim.o.cursorline     = true
    vim.o.cursorlineopt  = "number"
    vim.o.foldmethod     = "indent"
    vim.o.foldexpr       = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldlevel      = 99
    vim.o.laststatus     = 2
    vim.o.list           = true
    vim.o.ruler          = false
    vim.o.signcolumn     = 'yes'
    vim.o.splitbelow     = true
    vim.o.splitright     = true
    vim.o.termguicolors  = true
    vim.o.background     = 'light'
    vim.o.listchars      = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',')
    vim.o.fillchars      = table.concat(
        { 'eob: ', 'fold:╌', 'horiz:═', 'horizdown:╦', 'horizup:╩', 'vert:║', 'verthoriz:╬', 'vertleft:╣', 'vertright:╠' },
        ','
    )
    vim.o.smartindent    = true
    vim.o.autoindent     = true
    vim.o.formatoptions  = 'rqnl1j'
    vim.o.shiftwidth     = 4
    vim.o.tabstop        = 4
    vim.o.expandtab      = true
    vim.o.number         = true
    vim.o.relativenumber = false
    vim.o.ignorecase     = true
    vim.o.incsearch      = true
    vim.o.inccommand     = "split"
    vim.o.infercase      = true
    vim.o.scrolloff      = 10
    vim.o.clipboard      = "unnamed,unnamedplus"
    vim.o.spelllang      = 'en'
    vim.o.spelloptions   = 'camel'
    vim.o.swapfile       = false
    vim.opt.complete:append('kspell')
    vim.opt.iskeyword:append('-')
    -- vim.opt.statuscolumn = '%=%{v:lnum}│%{v:relnum}'


    vim.cmd('filetype plugin indent on')
    vim.cmd('colorscheme catppuccin')
end)

if vim.g.neovide then
    vim.o.guifont = "FiraCode Nerd Font:h10"
end

later(function() require('mini.ai').setup() end)
later(function() require('mini.align').setup() end)
later(function()
    -- This is needed for mini.animate to work with mouse scrolling
    vim.opt.mousescroll = 'ver:1,hor:1'
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
            basic = true,
            extra_ui = true,
            win_borders = 'bold',
        },
        mappings = {
            basic = true,
            windows = true,
        },
        autocommands = {
            basic = true,
            relnum_in_visual_mode = true,
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

            { mode = 'n', keys = '\\' },

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
            config = { anchor = 'NE', row = 'auto', col = 'auto' },
            delay = 300
        }
    })
end)
-- later(function() require('mini.colors').setup() end)
later(function() require('mini.comment').setup() end)
later(function()
    require('mini.completion').setup({
        mappings = {
            go_in = '<RET>',
        },
        window = {
            info = { border = 'rounded' },
            signature = { border = 'rounded' },
        },
        lsp_completion = {
            process_items = require('mini.fuzzy').process_lsp_items,
        },
    })
end)
later(function() require('mini.cursorword').setup() end)
later(function()
    require('mini.diff').setup({
        view = {
            style = 'sign',
            signs = { add = '█', change = '▒', delete = '' }
        }
    })
end)
later(function() require('mini.doc').setup() end)
later(function() require('mini.extra').setup() end)
later(function() require('mini.git').setup() end)
later(function()
    require('mini.files').setup({
        windows = {
            preview = true,
            width_preview = 80,
        },
        mappings = {
            go_in_plus = "<enter>",
        }
    })
end)
later(function() require('mini.fuzzy').setup() end)
later(function() require('mini.git').setup() end)
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
            '.*_pw: ()%S+()',
            'password_.*: ()%S+()',
            'gpg_pass: ()%S+()',
        },
        group = '',
        extmark_opts = censor_extmark_opts
    }
    -- TODO Make the "mask" Text a variale based on the match
    local mattern_extmark_opts = function(_, match, _)
        local mask = 'Rollout new Backup'
        return {
            virt_text = { { mask, 'FoldColumn' } },
            virt_text_pos = 'eol',
            priority = 199,
            right_gravity = true,
        }
    end

    local mattern_table = {
        pattern = {
            '.*backup_path:'
        },
        group = '',
        extmark_opts = mattern_extmark_opts
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
            mattern   = mattern_table,

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
-- later(function()
--     require('mini.hues').setup({
--         background = '#212030',
--         foreground = '#c6c6cd',
--         accent     = 'cyan',
--         saturation = 'medium'
--     })
-- end)

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
later(function()
    -- We took this from echasnovski's personal configuration
    -- https://github.com/echasnovski/nvim/blob/master/init.lua
    local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif) return not vim.startswith(notif.msg, 'lua_ls: Diagnosing') end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return MiniNotify.default_sort(notif_arr)
    end
    require('mini.notify').setup({
        content = { sort = filterout_lua_diagnosing },
        window = { config = { border = 'double' } },
    })
    vim.notify = MiniNotify.make_notify()
    print = MiniNotify.make_notify()
end)
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
    vim.ui.select = MiniPick.ui_select
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
            ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
            ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
            ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                               ]]
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
    require('lspconfig').pyright.setup{}
    require('lspconfig').clangd.setup {}
    require('lspconfig').gopls.setup {}
    require('lspconfig').rust_analyzer.setup {}
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
        settings = {
            ansible = {
                python = {
                    interpreterPath = 'python',
                },
                ansible = {
                    path = 'ansible',
                },
                executionEnvironment = {
                    enabled = false,
                },
                validation = {
                    enabled = true,
                    lint = {
                        enabled = true,
                        path = 'ansible-lint',
                        arguments = '-c /home/dosa/.config/ansible-lint.yml'
                    },
                },
            },
        },
    }
    require('lspconfig').yamlls.setup {}
    require('lspconfig').pyright.setup {}
end)

later(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter'
    })
    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'yaml' },
        auto_install = true,
        highlight = { enable = true, disable = { 'ini' } },
        indent = { enable = true }
    })
end)

later(function()
    add({
        source = 'supermaven-inc/supermaven-nvim',
    })
    require('supermaven-nvim').setup({})
end)

-- mini pick pickers + registry
later(function()
    MiniPick.registry.registry = function()
        local items = vim.tbl_extend("force", vim.tbl_keys(MiniExtra.pickers), vim.tbl_keys(MiniPick.registry))
        local source = { items = items, name = 'Registry', choose = function() end }
        local chosen_picker_name = MiniPick.start({ source = source })
        if chosen_picker_name == nil then return end
        local picker = MiniExtra.pickers[chosen_picker_name]
        if picker == nil then picker = MiniPick.registry[chosen_picker_name] end
        picker()
    end
end)

require("autocmds")
require("keybinds")
