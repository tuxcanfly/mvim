# MVIM

This is my NeoVim Configuration based entirely on [mini.nvim](https://github.com/echasnovski/mini.nvim)

And [lazy.nvim](https://github.com/folke/lazy.nvim). It's just more convenient than manualy Updating.

![Dashboard](screenshot_dashboard.png)
![Code](screenshot.png)

## Why?
Mostly because it's a single plugin with most functionality i need. So i can easily scp this to Servers without Internet Connection and still have my entire NeoVim Setup.
Additionaly, I was getting tired of maintaining a Configuration with as many plugins as i did. I wanted to see what mini has to offer and it turned out it can basically replace all my other Plugins.

No LSP or such though. I don't really use or need that in my day job.

## How Sessions Work

For now, you need to manualy create a Session first. So, launch MVIM, type `:lua MiniSessions.write('Sessionname')`
After that you can start editing and using MVIM like you normaly would. On Quitting MVIM, the Session is saved. It'll show up on the Dashboard and you can Select it with `<Leader>ss`
