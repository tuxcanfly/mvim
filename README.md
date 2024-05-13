# MVIM

This is my NeoVim Configuration based entirely on [mini.nvim](https://github.com/echasnovski/mini.nvim)

![Dashboard](mvim-dashboard.png)
![Code](mvim.png)

## Why?
Mostly because it's a single plugin with most functionality i need. So i can easily scp this to Servers without Internet Connection and still have my entire NeoVim Setup.
Additionaly, I was getting tired of maintaining a Configuration with as many plugins as i did. I wanted to see what mini has to offer and it turned out it can basically replace all my other Plugins.

No LSP or such though. I don't really use or need that in my day job.

## LSP Configuration
I do provide a minimal LSP Setup. This is enough for my personal use but can be extended.
The basic gist is, that you need to manually install your prefered LSPs through Mason and then add `require('lspconfig').yourlsp.setup {}` to init.lua
I'll add a more detailed description later.

## Colorschemes
Mini.nvim provieds three different option to set up a colorscheme:
- mini.colors
- mini.hues
- mini.base16
Per default we use mini.colors with our own colorscheme.

### mini.colors
If you want to add a new colorscheme, just copy one of the existing ones in the `colors` folder and edit it to your liking.
The plan for the future is, to extend this with some "favorite" colorschemes

### mini.hues
This creates a colorscheme based on a background and foreground color. Alternatively it provides a "randomhues" colorscheme that randomizes the look with each call.
You can uncomment this in `init.lua`, if you want to use it.

### mini.base16
Here we can provide a [base16](https://github.com/chriskempson/base16) theme. The 16 colors are provided through the "palette" array.
You can uncomment this in `init.lua`, if you want to use it. It's set up with a basic `catppuccin` inspired Colorscheme.

## How Sessions Work

For now, you need to manualy create a Session first. So, launch MVIM, type `:lua MiniSessions.write('Sessionname')`
After that you can start editing and using MVIM like you normaly would. On Quitting MVIM, the Session is saved. It'll show up on the Dashboard and you can Select it with `<Leader>ss`
