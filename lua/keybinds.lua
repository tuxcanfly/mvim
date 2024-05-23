-- ╔═══════════════════════╗
-- ║    Local Variables    ║
-- ╚═══════════════════════╝
local keymap = vim.keymap.set
local MiniPick = require('mini.pick')
local MiniFiles = require('mini.files')
local MiniSessions = require('mini.sessions')
local MiniExtra = require('mini.extra')

local split_sensibly = function()
    if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
        vim.cmd("vs")
    else
        vim.cmd("split")
    end
end

-- MiniPick Colorscheme Picker
local set_colorscheme = function(name) pcall(vim.cmd, 'colorscheme ' .. name) end
local pick_colorscheme = function()
    local init_scheme = vim.g.colors_name
    local new_scheme = MiniPick.start({
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
                    local item = MiniPick.get_picker_matches()
                    pcall(vim.cmd, 'colorscheme ' .. item.current)
                end
            }
        }
    })
    if new_scheme == nil then set_colorscheme(init_scheme) end
end

-- ╔═══════════════════════╗
-- ║    General Keymaps    ║
-- ╚═══════════════════════╝
keymap("n", "<leader>wq", "<cmd>wqa<cr>", { noremap = true, silent = true, desc = 'Quit' })
keymap("", "ö", ":")

-- ╔════════════════════╗
-- ║    Find Keymaps    ║
-- ╚════════════════════╝
keymap("n", "<leader>fs", function() MiniPick.builtin.files() end, { noremap = true, silent = true, desc = 'Find File' })
keymap("n", "<leader>e", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end,
    { noremap = true, silent = true, desc = 'Find Manualy' })
keymap("n", "<leader><space>", function() MiniPick.builtin.buffers() end,
    { noremap = true, silent = true, desc = 'Find Buffer' })
keymap("n", "<leader>fg", function() MiniPick.builtin.grep_live() end,
    { noremap = true, silent = true, desc = 'Find String' })
keymap("n", "<leader>fwg", function()
        local wrd = vim.fn.expand("<cWORD>")
        MiniPick.builtin.grep_live({ pattern = wrd })
    end,
    { noremap = true, silent = true, desc = 'Find String Cursor' })
keymap("n", "<leader>fh", function() MiniPick.builtin.help() end, { noremap = true, silent = true, desc = 'Find Help' })
keymap("n", "<leader>fl", function() MiniExtra.pickers.hl_groups() end,
    { noremap = true, silent = true, desc = 'Find HL Groups' })
keymap("n", "<leader>fc", pick_colorscheme, { noremap = true, silent = true, desc = 'Change Colorscheme' })
keymap('n', ',', function() MiniExtra.pickers.buf_lines({ scope = 'current' }) end, { nowait = true })

-- ╔═══════════════════════╗
-- ║    Session Keymaps    ║
-- ╚═══════════════════════╝
keymap("n", "<leader>ss", function()
    vim.cmd('wa')
    MiniSessions.write()
    MiniSessions.select()
end, { noremap = true, silent = true, desc = 'Switch Session' })
keymap("n", "<leader>sw", function() MiniSessions.write() end, { noremap = true, silent = true, desc = 'Save Session' })
keymap("n", "<leader>sf", function() MiniSessions.select() end, { noremap = true, silent = true, desc = 'Load Session' })

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
keymap("n", "<C-l>", "<cmd>bnext<cr>", { silent = true, desc = 'Next Buffer' })
keymap("n", "<C-h>", "<cmd>bprevious<cr>", { silent = true, desc = 'Previous Buffer' })
keymap("n", "<TAB>", "<C-^>", { noremap = true, silent = true, desc = "Alternate buffers" })
-- Format Buffer
-- With and without LSP
if vim.tbl_isempty(vim.lsp.buf_get_clients()) then
    keymap("n", "<leader>bf", function() vim.lsp.buf.format() end,
        { noremap = true, silent = true, desc = 'Format Buffer' })
else
    keymap("n", "<leader>bf", "gg=G<C-o>", { noremap = true, silent = true, desc = 'Format Buffer' })
end

-- ╔═══════════════════╗
-- ║    Git Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "<leader>gb", function() MiniExtra.pickers.git_commits({ path = vim.fn.expand('%:p') }) end,
    { desc = 'Git Log this File' })
keymap("n", "<leader>gl", function()
    split_sensibly()
    vim.cmd('terminal lazygit')
end, { noremap = true, silent = true, desc = 'Lazygit' })
keymap("n", "<leader>gp", "<cmd>:Git git pull<cr>", { noremap = true, silent = true, desc = 'Git Push' })
keymap("n", "<leader>gs", "<cmd>:Git git push<cr>", { noremap = true, silent = true, desc = 'Git Pull' })
keymap("n", "<leader>ga", "<cmd>:Git git add .<cr>", { noremap = true, silent = true, desc = 'Git Add All' })
keymap("n", "<leader>gc", '<cmd>:Git git commit -m "Autocommit from MVIM"<cr>',
    { noremap = true, silent = true, desc = 'Git Autocommit' })
keymap("n", "<leader>gh", function() require('mini.git').show_range_history() end,
    { noremap = true, silent = true, desc = 'Git Range History' })
keymap("n", "<leader>gx", function() require('mini.git').show_at_cursor() end,
    { noremap = true, silent = true, desc = 'Git Context Cursor' })

-- ╔═══════════════════╗
-- ║    LSP Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "<leader>ld", function() vim.lsp.buf.definition() end,
    { noremap = true, silent = true, desc = 'Go To Definition' })
keymap("n", "<leader>ls", "<cmd>Pick lsp scope='document_symbol'<cr>",
    { noremap = true, silent = true, desc = 'Show all Symbols' })
keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end, { noremap = true, silent = true, desc = 'Rename This' })
keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end,
    { noremap = true, silent = true, desc = 'Code Actions' })

-- ╔══════════════════╗
-- ║    UI Keymaps    ║
-- ╚══════════════════╝
-- Window Navigation
keymap("n", "<leader>wl", "<cmd>wincmd l<cr>", { noremap = true, silent = true, desc = 'Focus Left' })
keymap("n", "<leader>wk", "<cmd>wincmd k<cr>", { noremap = true, silent = true, desc = 'Focus Up' })
keymap("n", "<leader>wj", "<cmd>wincmd j<cr>", { noremap = true, silent = true, desc = 'Focus Down' })
keymap("n", "<leader>wh", "<cmd>wincmd h<cr>", { noremap = true, silent = true, desc = 'Focus Right' })
-- Alternate Window Navigation
keymap('n', '<S-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<S-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<S-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<S-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { noremap = true, silent = true, desc = 'Close Window' })
keymap("n", "<leader>n", "<cmd>noh<cr>", { noremap = true, silent = true, desc = 'Clear Search Highlight' })

-- Split "Sensibly"
-- Should automatically split or vsplit based on Ratios
keymap("n", "<leader>bs", split_sensibly, { noremap = true, silent = true, desc = "Alternate buffers" })

-- Change Colorscheme
keymap("n", "<leader>ud", "<cmd>set background=dark<cr>", { noremap = true, silent = true, desc = 'Dark Background' })
keymap("n", "<leader>ub", "<cmd>set background=light<cr>", { noremap = true, silent = true, desc = 'Light Background' })
keymap("n", "<leader>um", "<cmd>lua MiniMap.open()<cr>", { noremap = true, silent = true, desc = 'Mini Map' })
