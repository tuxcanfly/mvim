return {
    {
        'rebelot/kanagawa.nvim',
        enabled = mvim_mini(),
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        enabled = mvim_mini(),
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
        enabled = mvim_mini(),
        lazy = false,
        config = true,
    },
    {
        'neovim/nvim-lspconfig',
        enabled = mvim_mini(),
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
        enabled = mvim_mini(),
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
