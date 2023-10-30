-- 'Minicyan' color scheme
-- Derived from base16 (https://github.com/chriskempson/base16) and
-- mini_palette palette generator
local use_cterm, palette

-- Dark palette is an output of 'MiniBase16.mini_palette':
-- - Background '#0A2A2A' (LCh(uv) = 15-10-192)
-- - Foreground '#D0D0D0' (Lch(uv) = 83-0-0)
-- - Accent chroma 50
if vim.o.background == 'dark' then
  palette = {
    base00 = '#1e1e2e' ,
    base01 = '#181825' ,
    base02 = '#313244' ,
    base03 = '#45475a' ,
    base04 = '#585b70' ,
    base05 = '#cdd6f4' ,
    base06 = '#f5e0dc' ,
    base07 = '#b4befe' ,
    base08 = '#f38ba8' ,
    base09 = '#fab387' ,
    base0A = '#f9e2af' ,
    base0B = '#a6e3a1' ,
    base0C = '#94e2d5' ,
    base0D = '#89b4fa' ,
    base0E = '#cba6f7' ,
    base0F = '#f2cdcd'
  }
  use_cterm = {
    base00 = 235,
    base01 = 238,
    base02 = 241,
    base03 = 102,
    base04 = 250,
    base05 = 252,
    base06 = 254,
    base07 = 231,
    base08 = 186,
    base09 = 136,
    base0A = 29,
    base0B = 115,
    base0C = 132,
    base0D = 153,
    base0E = 218,
    base0F = 67,
  }
end

-- Light palette is an 'inverted dark', output of 'MiniBase16.mini_palette':
-- - Background '#C0D2D2' (LCh(uv) = 83-10-192)
-- - Foreground '#262626' (Lch(uv) = 15-0-0)
-- - Accent chroma 80
if vim.o.background == 'light' then
  palette = {
    base00 = '#1e1e2e',
    base01 = '#181825',
    base02 = '#313244',
    base03 = '#45475a',
    base04 = '#585b70',
    base05 = '#cdd6f4',
    base06 = '#f5e0dc',
    base07 = '#b4befe',
    base08 = '#f38ba8',
    base09 = '#fab387',
    base0A = '#f9e2af',
    base0B = '#a6e3a1',
    base0C = '#94e2d5',
    base0D = '#89b4fa',
    base0E = '#cba6f7',
    base0F = '#f2cdcd'
  }
  use_cterm = {
    base00 = 252,
    base01 = 248,
    base02 = 102,
    base03 = 241,
    base04 = 237,
    base05 = 235,
    base06 = 234,
    base07 = 232,
    base08 = 235,
    base09 = 94,
    base0A = 29,
    base0B = 22,
    base0C = 126,
    base0D = 25,
    base0E = 89,
    base0F = 25,
  }
end

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = 'catppuccin'
end
