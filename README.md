# MVIM

This is my NeoVim Configuration based entirely on [mini.nvim](https://github.com/echasnovski/mini.nvim)

And [lazy.nvim](https://github.com/folke/lazy.nvim). It's just more convenient than manualy Updating.

![Dashboard](screenshot_dashboard.png)
![Code](screenshot.png)

## Why?
Mostly because it's a single plugin with most functionality i need. So i can easily scp this to Servers without Internet Connection and still have my entire NeoVim Setup.
Additionaly, I was getting tired of maintaining a Configuration with as many plugins as i did. I wanted to see what mini has to offer and it turned out it can basically replace all my other Plugins.

No LSP or such though. I don't really use or need that in my day job.

## Versions
The Repository contains three "Edition" of Mvim.

These Editions can be used through branches. I'll add the one-liners to clone the specific branch later below. But the gist of it is:
- Clone this Repo
- cd into the repo
- git checkout 'edition'

### Main
This is the main "recommended" Edition of Mvim. It contains mini.nvim with all the setup, plus a basic LSP setup.

### Mini
This is the "Mini only" Edition of Mvim. It doesn't come with the LSP Setup and only uses lazy plus mini.nvim.

### Maxi
This is the "All the Features Please" Edition of Mvim. I add stuff like Snippets, Neo-Tree, Harpoon and other Plugins i'm either Testing or Enjoy in daily use, but don't feel like Fit the ethos of "Mvim".
It's pretty much my "Daily Driver" Config that's more involved than the basic "Mini and LSP" Setup.
I don't recommend using this. Mostly because it contains a lot of Personal configuration that's specific to me, but also because i feel like this kind of extensive Setup is done better by other Distributions like Lazyvim or NVChad.

## How Sessions Work

For now, you need to manualy create a Session first. So, launch MVIM, type `:lua MiniSessions.write('Sessionname')`
After that you can start editing and using MVIM like you normaly would. On Quitting MVIM, the Session is saved. It'll show up on the Dashboard and you can Select it with `<Leader>ss`
