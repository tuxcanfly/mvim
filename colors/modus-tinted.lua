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
        base00 = '#0d0e1c', -- Default Background
        base01 = '#1d2235', -- Lighter Background (Used for status bars, line number and folding marks)
        base02 = '#004065', -- Selection Background
        base03 = '#989898', -- Comments, Invisibles, Line Highlighting
        base04 = '#989898', -- Dark Foreground (Used for status bars)
        base05 = '#ffffff', -- Default Foreground, Caret, Delimiters, Operators
        base06 = '#c6daff', -- Light Foreground (Not often used)
        base07 = '#c6daff', -- Light Background (Not often used)
        base08 = '#00d3d0', -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
        base09 = '#00bcff', -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
        base0A = '#00c06f', -- Classes, Markup Bold, Search Text Background
        base0B = '#00bcff', -- Strings, Inherited Class, Markup Code, Diff Inserted
        base0C = '#ff7f9f', -- Support, Regular Expressions, Escape Characters, Markup Quotes
        base0D = '#2fafff', -- Functions, Methods, Attribute IDs, Headings
        base0E = '#b6a0ff', -- Keywords, Storage, Selector, Markup Italic, Diff Changed
        base0F = '#b6a0ff'  -- Deprecated, Opening/Closing Embedded Language Tags
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
        base00 = '#fbf7f0', -- Default Background
        base01 = '#efe9dd', -- Lighter Background (Used for status bars, line number and folding marks)
        base02 = '#c9b9b0', -- Selection Background
        base03 = '#595959', -- Comments, Invisibles, Line Highlighting
        base04 = '#193668', -- Dark Foreground (Used for status bars)
        base05 = '#000000', -- Default Foreground, Caret, Delimiters, Operators
        base06 = '#595959', -- Light Foreground (Not often used)
        base07 = '#595959', -- Light Background (Not often used)
        base08 = '#005e8b', -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
        base09 = '#00663f', -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
        base0A = '#005f5f', -- Classes, Markup Bold, Search Text Background
        base0B = '#8f0075', -- Strings, Inherited Class, Markup Code, Diff Inserted
        base0C = '#005f5f', -- Support, Regular Expressions, Escape Characters, Markup Quotes
        base0D = '#721045', -- Functions, Methods, Attribute IDs, Headings
        base0E = '#7c318f', -- Keywords, Storage, Selector, Markup Italic, Diff Changed
        base0F = '#972500', -- Deprecated, Opening/Closing Embedded Language Tags
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
    vim.g.colors_name = 'modus-tinted'
end
