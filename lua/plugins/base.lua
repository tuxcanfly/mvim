return {
    'equalsraf/neovim-gui-shim',
    {
        "echasnovski/mini.nvim",
        config = function()
            require('mini.ai').setup()
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
                    width_preview = 80,
                }
            })
            require('mini.fuzzy').setup()
            require('mini.hipatterns').setup()
            -- require('mini.hues').setup({ background = '#282828', foreground = '#EBDBB2' })
            require('mini.indentscope').setup({
                draw = {
                    animation = function() return 1 end,
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
            -- require('mini.pairs').setup()
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
                footer = function()
                    local stats = require('lazy.stats').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return "Startup Time: " .. ms .. " ms"
                end
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
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("nvim-treesitter.configs").setup({
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        node_incremental = "v",
                        node_decremental = "V",
                    },
                }
            })
        end
    }
}
