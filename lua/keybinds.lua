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

--  ─( Colorscheme Picker )─────────────────────────────────────────────
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

-- ╔═══════════════════════╗
-- ║    General Keymaps    ║
-- ╚═══════════════════════╝
keymap("n", "<leader>q", "<cmd>wqa<cr>", { desc = 'Quit' })
keymap("n", "ö", ":")
keymap("i", "<C-S-v>", "<C-r><C-o>*", { desc = 'Paste from System in Insertmode' })
keymap("n", "<leader>mu", function() require('mini.deps').update() end, { desc = 'Update Plugins' })
keymap("n", "<S-Insert>", "p", { desc = 'Remap Paste for CopyQ' })
keymap("i", "<S-Insert>", "<C-R>+", { desc = 'Remap Paste for CopyQ' })

-- ╔════════════════════╗
-- ║    Find Keymaps    ║
-- ╚════════════════════╝
keymap("n", "<leader>e", function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
        require('mini.files').open(path)
    end,
    { noremap = true, silent = true, desc = 'Find Manually' })
keymap("n", "<leader><space>", function() require('mini.pick').builtin.buffers() end,
    { noremap = true, silent = true, desc = 'Find Buffer' })
keymap("n", "\'", function() require('mini.extra').pickers.commands() end,
    { noremap = true, silent = true, desc = 'Find Command' })
keymap("n", "//", function() require('mini.pick').builtin.grep_live() end,
    { noremap = true, silent = true, desc = 'Find String' })
keymap("n", ",", function() require('mini.pick').builtin.files() end,
    { noremap = true, silent = true, desc = 'Find File' })
keymap("n", "|", function() require('mini.pick').registry.registry() end,
    { noremap = true, silent = true, desc = 'Find Picker' })
keymap("n", "<leader>s", function() require('mini.extra').pickers.git_hunks() end,
    { noremap = true, silent = true, desc = 'Git Status' })
keymap("n", "<leader>~", pick_colorscheme, { noremap = true, silent = true, desc = 'Find Colorscheme' })
keymap("n", "<leader>?", function() require('mini.pick').builtin.help() end,
    { noremap = true, silent = true, desc = 'Find Help' })

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
    { desc = 'Insert Password' })

keymap("n", "YY", "<cmd>%y<cr>", { desc = 'Yank Buffer' })
keymap("n", "<Esc>", "<cmd>noh<cr>", { desc = 'Clear Search' })

-- ╔══════════════════════╗
-- ║    Buffer Keymaps    ║
-- ╚══════════════════════╝
keymap("n", "<leader>bd", "<cmd>bd<cr>", { desc = 'Close Buffer' })
keymap("n", "<leader>bq", "<cmd>%bd|e#<cr>", { desc = 'Close other Buffers' })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = 'Next Buffer' })
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = 'Previous Buffer' })
keymap("n", "<TAB>", "<C-^>", { desc = "Alternate buffers" })
-- Format Buffer
-- With and without LSP
if vim.tbl_isempty(vim.lsp.buf_get_clients()) then
    keymap("n", "<leader>bf", function() vim.lsp.buf.format() end,
        { desc = 'Format Buffer' })
else
    keymap("n", "<leader>bf", "gg=G<C-o>", { desc = 'Format Buffer' })
end
keymap("n", "<C-s>", ":noa wa<cr>", { noremap = true, silent = true, desc = "Save" })
keymap("n", "<C-q>", ":noa wqa<cr>", { noremap = true, silent = true, desc = "Exit" })

-- ╔═══════════════════╗
-- ║    Git Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "<leader>gb", function() require('mini.extra').pickers.git_commits({ path = vim.fn.expand('%:p') }) end,
    { desc = 'Git Log this File' })
keymap("n", "<leader>gg", ":terminal lazygit<cr>", { noremap = true, silent = true, desc = 'Lazygit' })
keymap("n", "<leader>gp", ":Git pull<cr>", { noremap = true, silent = true, desc = 'Git Push' })
keymap("n", "<leader>gs", ":Git push<cr>", { noremap = true, silent = true, desc = 'Git Pull' })
keymap("n", "<leader>ga", ":Git add .<cr>", { noremap = true, silent = true, desc = 'Git Add All' })
keymap("n", "<leader>gc", ':Git commit -m "Autocommit from MVIM"<cr>',
    { noremap = true, silent = true, desc = 'Git Autocommit' })
keymap("n", "<leader>gh", function() require('mini.git').show_range_history() end,
    { noremap = true, silent = true, desc = 'Git Range History' })
keymap("n", "<leader>gx", function() require('mini.git').show_at_cursor() end,
    { noremap = true, silent = true, desc = 'Git Context Cursor' })

-- ╔═══════════════════╗
-- ║    LSP Keymaps    ║
-- ╚═══════════════════╝
keymap("n", "gR", function() require('mini.extra').pickers.lsp({ scope = 'references' }) end,
    { noremap = true, silent = true, desc = 'Go To Definition' })
keymap("n", "gd", function() vim.lsp.buf.definition() end, { noremap = true, silent = true, desc = 'Go To Definition' })
keymap("n", "<C-p>", "<cmd>Pick lsp scope='document_symbol'<cr>",
    { noremap = true, silent = true, desc = 'Show all Symbols' })
keymap("n", "<leader>lr", function() vim.lsp.buf.rename() end, { noremap = true, silent = true, desc = 'Rename This' })
keymap("n", "<leader>la", function() vim.lsp.buf.code_action() end,
    { noremap = true, silent = true, desc = 'Code Actions' })

-- ╔══════════════════╗
-- ║    UI Keymaps    ║
-- ╚══════════════════╝
-- Window Navigation
keymap("n", "<M-n>", "<cmd>wincmd l<cr>", { desc = 'Focus Left' })
keymap("n", "<M-r>", "<cmd>wincmd k<cr>", { desc = 'Focus Up' })
keymap("n", "<M-t>", "<cmd>wincmd j<cr>", { desc = 'Focus Down' })
keymap("n", "<M-d>", "<cmd>wincmd h<cr>", { desc = 'Focus Right' })

keymap("n", "<leader>ur", "<cmd>colorscheme randomhue<cr>", { desc = 'Random Colorscheme' })

keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { desc = 'Close Window' })
keymap("n", "<leader>n", "<cmd>noh<cr>", { desc = 'Clear Search Highlight' })

--  ─( Split "Sensibly" )───────────────────────────────────────────────
-- Should automatically split or vsplit based on Ratios
keymap("n", "<leader>bs", split_sensibly, { desc = "Alternate buffers" })

--  ─( Change Colorscheme )─────────────────────────────────────────────
keymap("n", "<leader>ud", "<cmd>set background=dark<cr>", { desc = 'Dark Background' })
keymap("n", "<leader>ub", "<cmd>set background=light<cr>", { desc = 'Light Background' })
keymap("n", "<leader>um", "<cmd>lua MiniMap.open()<cr>", { desc = 'Mini Map' })

--  ─( Neotree )────────────────────────────────────────────────────────
-- keymap("n", "<leader>tt", "<cmd>Neotree toggle<cr>", { desc = 'Neotree' })
keymap("n", "<leader>tt", function()
    local reveal_file = vim.fn.expand('%:p')
    if (reveal_file == '') then
        reveal_file = vim.fn.getcwd()
    else
        local f = io.open(reveal_file, "r")
        if (f) then
            f.close(f)
        else
            reveal_file = vim.fn.getcwd()
        end
    end
    require("neo-tree.command").execute({
        action = "focus",
        source = "filesystel",
        position = "left",
        reveal_file = reveal_file,
        reveal_force_cwd = true,
    })
end, { desc = 'Neotree' })

--  ─( Trying a "Center Code" Keymap )──────────────────────────────────
keymap("n", "<leader>uc", function()
    local margin = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(margin, false, {
        split = 'left',
        win = 0,
        style = 'minimal',
        width = 40
    })
end, { desc = 'Center Buffer' })
