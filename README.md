# MVIM

This is my NeoVim Configuration based entirely on [mini.nvim](https://github.com/echasnovski/mini.nvim)

![Dashboard](mvim-dashboard.png)
![Code](mvim.png)

## Why?
Mostly because it's a single plugin with most functionality i need. So i can easily scp this to Servers without Internet Connection and still have my entire NeoVim Setup.
Additionaly, I was getting tired of maintaining a Configuration with as many plugins as i did. I wanted to see what mini has to offer and it turned out it can basically replace all my other Plugins.

## Dependencies
This configuration should mostly work on it's own without anything else. To get it you need git (obviously).
I have provided a keymap for lazygit (`<leader>gl`), so you should install this if you want to use that.
I'm not going to go over how to get the tools you need to install LSPs. Others have done that much better already.

## Things to configure
Compared to nvim Distributions, this is mostly my personal Configuration as is. This also means that it contains some Settings, that probably don't work for you, or should be extended

### Hipatterns
I use mini.hipatterns to hide Passwords from files. This helps when screensharing in Meetings. This is based on matching a regex before the password. Please look at the hipatterns configuration
in my init.lua and add/remove patterns you don't need. Else this could lead to code being hidden.

### LSP Configuration
I do provide a minimal LSP Setup. This is enough for my personal use but can be extended.
The basic gist is, that you need to manually install your prefered LSPs through Mason and then add `require('lspconfig').yourlsp.setup {}` to init.lua
I'll add a more detailed description later.

## Colorschemes
Mini.nvim provieds two different option to set up a colorscheme:
- mini.hues
- mini.base16
Per default we use mini.base16 with our own colorscheme, inspired by the emacs modus themes by protesilaos.
It should be noted though, that the dev of mini.base16 feels like it doesn't do highlighting as well as neovim could, as it closely follows the base16 specification. You can change the theme to randomhue
or manually configure mini.hues for a more coherent look.

### mini.hues
This creates a colorscheme based on a background and foreground color. Alternatively it provides a "randomhues" colorscheme that randomizes the look with each call.
You can uncomment this in `init.lua`, if you want to use it.

### mini.base16
Here we can provide a [base16](https://github.com/chriskempson/base16) theme. The 16 colors are provided through the "palette" array.
You can uncomment this in `init.lua`, if you want to use it. It's set up with a basic `catppuccin` inspired Colorscheme.
This is also used to provide the themes in the "colors/" folder. If you want more than one theme, you can copy one of those and insert your own colors. This is also the way to get dark/light mode of the same theme.

## How Sessions Work
For now, you need to manualy create a Session first. So, launch MVIM, type `:lua MiniSessions.write('Sessionname')`
After that you can start editing and using MVIM like you normaly would. On Quitting MVIM, the Session is saved. It'll show up on the Dashboard and you can get a Session selection with `<Leader>sf`.
I plan on updating the keybinds to something that automatically infers the session name from cwd.

## Unique things
Since this is my personal Configuration, there might be things that work differently from other distributions. I'm not going over keybinds mostly, as you can discover them through mini.clues (just press space, it shows up on the bottom right).
I did, however, rebind the umlaut "ö" to colon in normal and visual mode. It's the same spot where colon would be on a QWERTY keyboard. I just use a QWERTZ layout.
