return {
    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { "<leader>hd", function() require("harpoon.mark").add_file() end,        desc = 'Harpoon add' },
            { "<leader>hv", function() require("harpoon.ui").toggle_quick_menu() end, desc = 'Harpoon Menu' },
            { "<leader>hl", function() require("harpoon.ui").nav_next() end,          desc = 'Harpoon Next' },
            { "<leader>hk", function() require("harpoon.ui").nav_prev() end,          desc = 'Harpoon Previous' },
        }
    },
    {
        'laytan/cloak.nvim',
        keys = {
            { "<leader>uc", "<cmd>CloakToggle<cr>", desc = "Toggle Cloaking" }
        },
        ft = {
            'yaml'
        },
        config = function()
            require('cloak').setup({
                enabled = true,
                cloak_character = '*',
                highlight_group = 'Comment',
                cloak_length = nil,
                try_all_patterns = true,
                patterns = {
                    {
                        file_pattern = {
                            '.env*',
                            '*.yml',
                        },
                        cloak_pattern = {
                            '=.+',
                            { '(pw: ).+',           replace = '%1' },
                            { '(pass: ).+',         replace = '%1' },
                            { '(passwd: ).+',       replace = '%1' },
                            { '(password: ).+',     replace = '%1' },
                            { '(password_usr: ).+', replace = '%1' },
                        },
                        -- A function, table or string to generate the replacement.
                        -- The actual replacement will contain the 'cloak_character'
                        -- where it doesn't cover the original text.
                        -- If left emtpy the legacy behavior of keeping the first character is retained.
                        replace = nil,
                    },
                },
            })
        end
    },
    {
        "tris203/hawtkeys.nvim",
        keys = {
            { "<leader>fk", "<cmd>Hawtkeys<cr>", desc = 'Hawtkeys' }
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = {
        },
    }
}
