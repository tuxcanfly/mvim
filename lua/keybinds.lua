-- ╔═══════════════════════╗
-- ║    Local Variables    ║
-- ╚═══════════════════════╝
local keymap = vim.keymap.set

local split_sensibly = function()
    if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
        vim.cmd("vs")
    else
        vim.cmd("split")
    end
end

-- require('mini.pick') Colorscheme Picker
local set_colorscheme = function(name) pcall(vim.cmd, 'colorscheme ' .. name) end
local pick_colorscheme = function()
    local init_scheme = vim.g.colors_name
    local new_scheme = require('mini.pick').start({
        source = {
            items = vim.fn.getcompletion("", "color"),
            preview = function(_, item)
                set_colorscheme(item)
            end,
            choose = set_colorscheme
        },
        mappings = {
            preview = {
                char = '<C-p>',
                func = function()
                    local item = require('mini.pick').get_picker_matches()
                    pcall(vim.cmd, 'colorscheme ' .. item.current)
                end
            }
        }
    })
    if new_scheme == nil then set_colorscheme(init_scheme) end
end

-- ╔════════════════════╗
-- ║    Find Keymaps    ║
-- ╚════════════════════╝
keymap("n", "<leader>e", function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end, { noremap = true, silent = true, desc = 'Find Manually' })
keymap("n", "<leader><space>", function() require('mini.pick').builtin.buffers() end, { noremap = true, silent = true, desc = 'Find Buffer' })
keymap("n", "\'", function() require('mini.extra').pickers.commands() end, { noremap = true, silent = true, desc = 'Find Command' })
keymap("n", "//", function() require('mini.pick').builtin.grep_live() end, { noremap = true, silent = true, desc = 'Find String' })
keymap("n", ",", function() require('mini.pick').builtin.files() end, { noremap = true, silent = true, desc = 'Find File' })
keymap("n", "|", function() require('mini.pick').registry.registry() end, { noremap = true, silent = true, desc = 'Find Picker' })
keymap("n", "<leader>s", function() require('mini.extra').pickers.git_hunks() end, { noremap = true, silent = true, desc = 'Git Status' })
keymap("n", "<leader>C", pick_colorscheme, { noremap = true, silent = true, desc = 'Find Colorscheme' })
keymap("n", "<leader>?", function() require('mini.pick').builtin.help() end, { noremap = true, silent = true, desc = 'Find Help' })

-- ╔═══════════════════════╗
-- ║    Editing Keymaps    ║
-- ╚═══════════════════════╝
-- Insert a Password at point
keymap("n", "<leader>ip",
    function()
        local command = 'pwgen -N 1 -B 32'
        for _, line in ipairs(vim.fn.systemlist(command)) do
            vim.api.nvim_put({ line }, '', true, true)
        end
    end,
    { noremap = true, silent = true, desc = 'Insert Password' })

-- ╔══════════════════════╗
-- ║    Buffer Keymaps    ║
-- ╚══════════════════════╝
keymap("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, silent = true, desc = 'Close Buffer' })
keymap("n", "<leader>bq", "<cmd>%bd|e#<cr>", { noremap = true, silent = true, desc = 'Close other Buffers' })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { silent = true, desc = 'Next Buffer' })
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { silent = true, desc = 'Previous Buffer' })
keymap("n", "<TAB>", "<C-^>", { noremap = true, silent = true, desc = "Alternate buffers" })
-- Format Buffer
-- With and without LSP
if vim.tbl_isempty(vim.lsp.buf_get_clients()) then
    keymap("n", "<leader>bf", function() vim.lsp.buf.format() end,
        { noremap = true, silent = true, desc = 'Format Buffer' })
else
    keymap("n", "<leader>bf", "gg=G<C-o>", { noremap = true, silent = true, desc = 'Format Buffer' })
end
keymap("n", "<C-s>", ":noa wa<cr>", { noremap = true, silent = true, desc = "Save" })
keymap("n", "<C-q>", ":noa wqa<cr>", { noremap = true, silent = true, desc = "Exit" })

-- ╔═══════════════════╗
-- ║    Git Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "<leader>gb", function() require('mini.extra').pickers.git_commits({ path = vim.fn.expand('%:p') }) end, { desc = 'Git Log this File' })
keymap("n", "<leader>gg", ":terminal lazygit<cr>", { noremap = true, silent = true, desc = 'Lazygit' })
keymap("n", "<leader>gp", ":Git pull<cr>", { noremap = true, silent = true, desc = 'Git Push' })
keymap("n", "<leader>gs", ":Git push<cr>", { noremap = true, silent = true, desc = 'Git Pull' })
keymap("n", "<leader>ga", ":Git add .<cr>", { noremap = true, silent = true, desc = 'Git Add All' })
keymap("n", "<leader>gc", ':Git commit -m "Autocommit from MVIM"<cr>', { noremap = true, silent = true, desc = 'Git Autocommit' })
keymap("n", "<leader>gh", function() require('mini.git').show_range_history() end, { noremap = true, silent = true, desc = 'Git Range History' })
keymap("n", "<leader>gx", function() require('mini.git').show_at_cursor() end, { noremap = true, silent = true, desc = 'Git Context Cursor' })

-- ╔═══════════════════╗
-- ║    LSP Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "gR", function() require('mini.extra').pickers.lsp({ scope = 'references' }) end, { noremap = true, silent = true, desc = 'Go To Definition' })
keymap("n", "gd", function() vim.lsp.buf.definition() end, { noremap = true, silent = true, desc = 'Go To Definition' })
keymap("n", "<leader>ls", "<cmd>Pick lsp scope='document_symbol'<cr>", { noremap = true, silent = true, desc = 'Show all Symbols' })
keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end, { noremap = true, silent = true, desc = 'Rename This' })
keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end, { noremap = true, silent = true, desc = 'Code Actions' })

-- ╔══════════════════╗
-- ║    UI Keymaps    ║
-- ╚══════════════════╝
-- Window Navigation
keymap("n", "<leader>wl", "<cmd>wincmd l<cr>", { noremap = true, silent = true, desc = 'Focus Left' })
keymap("n", "<leader>wk", "<cmd>wincmd k<cr>", { noremap = true, silent = true, desc = 'Focus Up' })
keymap("n", "<leader>wj", "<cmd>wincmd j<cr>", { noremap = true, silent = true, desc = 'Focus Down' })
keymap("n", "<leader>wh", "<cmd>wincmd h<cr>", { noremap = true, silent = true, desc = 'Focus Right' })
-- Alternate Window Navigation
-- keymap('n', '<S-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- keymap('n', '<S-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- keymap('n', '<S-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- keymap('n', '<S-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { noremap = true, silent = true, desc = 'Close Window' })
keymap("n", "<leader>n", "<cmd>noh<cr>", { noremap = true, silent = true, desc = 'Clear Search Highlight' })

-- Split "Sensibly"
-- Should automatically split or vsplit based on Ratios
keymap("n", "<leader>bs", split_sensibly, { noremap = true, silent = true, desc = "Alternate buffers" })

-- Change Colorscheme
keymap("n", "<leader>ud", "<cmd>set background=dark<cr>", { noremap = true, silent = true, desc = 'Dark Background' })
keymap("n", "<leader>ub", "<cmd>set background=light<cr>", { noremap = true, silent = true, desc = 'Light Background' })
keymap("n", "<leader>um", "<cmd>lua MiniMap.open()<cr>", { noremap = true, silent = true, desc = 'Mini Map' })
