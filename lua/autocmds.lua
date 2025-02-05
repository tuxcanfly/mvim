-- Automatically close terminal Buffers when their Process is done
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd("setlocal nonumber norelativenumber signcolumn=no | startinsert ")
    end
})
vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        vim.cmd("bdelete")
    end
})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = ev.buf,
        callback = function()
            vim.lsp.buf.format { async = false }
        end
    })
    end
})

-- Automatically Split help Buffers to the right
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L"
})

-- Autosave on Idle
-- vim.o.updatetime controls the amount of time
-- set this in init.lua
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    command = "silent! w"
})

-- Mini.Files Border Style
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
        local win_id = args.data.win_id

        -- Customize window-local settings
        vim.api.nvim_win_set_config(win_id, { border = 'single' })
    end,
})

-- Add Padding to Mini.Files Window Titles
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowUpdate',
    callback = function(args)
        local config = vim.api.nvim_win_get_config(args.data.win_id)

        -- Ensure title padding
        if config.title[#config.title][1] ~= ' ' then
            table.insert(config.title, { ' ', 'NormalFloat' })
        end
        if config.title[1][1] ~= ' ' then
            table.insert(config.title, 1, { ' ', 'NormalFloat' })
        end

        vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
})

-- Navigate the Quickfix List
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set('n', '<C-j>', '<cmd>cn<CR>zz<cmd>wincmd p<CR>', opts)
    vim.keymap.set('n', '<C-k>', '<cmd>cN<CR>zz<cmd>wincmd p<CR>', opts)
  end,
})
