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
