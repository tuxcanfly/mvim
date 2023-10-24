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
    base00 = '#202428',
    base01 = '#303438',
    base02 = '#404448',
    base03 = '#606468',
    base04 = '#b0b4b8',
    base05 = '#d0d4d8',
    base06 = '#e0e4e8',
    base07 = '#ffffff',
    base08 = '#ff3d3d',
    base09 = '#ffaa3d',
    base0A = '#ffff3d',
    base0B = '#aaff3d',
    base0C = '#3daaff',
    base0D = '#3dddaa',
    base0E = '#d399ff',
    base0F = '#ffaaaa'
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
    base00 = '#f0f4f8',
    base01 = '#e0e4e8',
    base02 = '#d0d4d8',
    base03 = '#b0b4b8',
    base04 = '#505458',
    base05 = '#404448',
    base06 = '#303438',
    base07 = '#202428',
    base08 = '#d30000',
    base09 = '#f37c22',
    base0A = '#88aa00',
    base0B = '#147624',
    base0C = '#006bbd',
    base0D = '#157a5a',
    base0E = '#9c1aff',
    base0F = '#b64422',
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
  vim.g.colors_name = 'minicyan'
end
