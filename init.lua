local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.listchars = { extends='.',precedes='|',nbsp='_', tab='└─┘' }
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true

vim.filetype.add({
  filename = {
    ['inventory'] = 'dosini',
  }
})

require("lazy").setup({
    {
        "nvim-tree/nvim-web-devicons"
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
          vim.cmd.colorscheme "gruvbox"
        end
    },
    {
      "echasnovski/mini.nvim",
      version = false,
      config = function()
        require('mini.statusline').setup()
        require('mini.animate').setup({
          scroll = {
              enable = false,
          }
        })
        require('mini.basics').setup({
          options = {
              extra_ui = true,
              win_borders = 'double',
          },
          mappings = {
              windows = true,
          }
        })
        require('mini.comment').setup()
        require('mini.completion').setup()
        require('mini.files').setup()
        require('mini.move').setup()
        require('mini.indentscope').setup({
          draw = {
              animation = function(s, n) return 5 end,
          },
          symbol = "│"
        })
        require('mini.pairs').setup()
        require('mini.pick').setup({
            options = {
                use_cache = true
            }
        })
        require('mini.sessions').setup({
            autowrite = true
        })
        require('mini.starter').setup({
            header = "███╗   ███╗██╗   ██╗██╗███╗   ███╗\n████╗ ████║██║   ██║██║████╗ ████║\n██╔████╔██║██║   ██║██║██╔████╔██║\n██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║\n██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║\n╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝\n                                  "
        })
        require('mini.surround').setup()
        require('mini.tabline').setup()
      end
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      config = function()
              local wk = require("which-key")
          wk.register({
              f = {
                  name = "find",
                  f = { function () MiniPick.builtin.files() end, "Find File" },
                  m = { function () MiniFiles.open() end, "Find File Manualy" },
                  b = { function () MiniPick.builtin.buffers() end, "Find Buffer" },
                  s = { function () MiniPick.builtin.grep_live() end, "Find String" },
              },
              s = {
                  name = "Session",
                  s = { function() MiniSessions.select() end, "Select Session" },
              },
              b = {
                  name = "Buffer",
                  d = {"<cmd>bd<cr>", "Close Current Buffer"},
              },
          }, { prefix = "<leader>" })
      end
    },
})
