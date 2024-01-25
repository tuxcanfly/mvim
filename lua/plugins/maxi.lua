return {

    'equalsraf/neovim-gui-shim',
    'folke/tokyonight.nvim',
    'rebelot/kanagawa.nvim',
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
    --
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
