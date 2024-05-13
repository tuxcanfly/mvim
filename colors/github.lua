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
      base01 = '#161b22',
      base02 = '#21262d',
      base03 = '#89929b',
      base04 = '#c6cdd5',
      base05 = '#ecf2f8',
      base06 = '#c6cdd5',
      base07 = '#c6cdd5',
      base08 = '#77bdfb',
      base09 = '#a2d2fb',
      base0A = '#faa356',
      base0B = '#7ce38b',
      base0C = '#fa7970',
      base0D = '#cea5fb',
      base0E = '#cea5fb',
      base0F = '#fa7970',
      base00 = '#0d1117'
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
      base01 = '#f5f5f5',
      base02 = '#c8c8fa',
      base03 = '#969896',
      base04 = '#e8e8e8',
      base05 = '#333333',
      base06 = '#ffffff',
      base07 = '#ffffff',
      base08 = '#ed6a43',
      base09 = '#0086b3',
      base0A = '#795da3',
      base0B = '#183691',
      base0C = '#183691',
      base0D = '#795da3',
      base0E = '#a71d5d',
      base0F = '#333333',
      base00 = '#ffffff'
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
  vim.g.colors_name = 'github'
end
