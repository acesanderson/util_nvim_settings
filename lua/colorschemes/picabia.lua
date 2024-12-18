-- picabia.lua
local M = {}

-- Color Palette derived from Picabia's Catch as catch can
local colors = {
    bg = "#1A1814",           -- Deep charcoal background
    fg = "#E6E2DD",           -- Off-white
    terra = "#C4634B",        -- Terracotta
    ochre = "#B6935A",        -- Ochre/golden brown
    blue = "#324866",         -- Deep blue accents
    cream = "#D5CCBB",        -- Cream highlights
    brown = "#8B5E3C",        -- Rich brown
    grey = "#9A958F",         -- Neutral grey
    none = "NONE"
}

function M.setup()
    -- Reset highlighting
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    -- Set colorscheme name
    vim.g.colors_name = "picabia"

    -- Editor highlights
    local highlights = {
        -- UI Elements
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg },
        LineNr = { fg = colors.grey },
        CursorLine = { bg = "#242018" },  -- Slightly lighter than bg
        CursorLineNr = { fg = colors.terra },
        SignColumn = { bg = colors.bg },
        Pmenu = { fg = colors.fg, bg = colors.bg },
        PmenuSel = { fg = colors.bg, bg = colors.terra },
        StatusLine = { fg = colors.terra, bg = colors.bg },
        Comment = { fg = colors.grey, italic = true },
        Constant = { fg = colors.terra },
        String = { fg = colors.ochre },
        Character = { fg = colors.ochre },
        Number = { fg = colors.cream },
        Boolean = { fg = colors.terra },
        Float = { fg = colors.cream },
        Identifier = { fg = colors.fg },
        Function = { fg = colors.terra },
        Statement = { fg = colors.blue },
        Conditional = { fg = colors.blue },
        Repeat = { fg = colors.blue },
        Label = { fg = colors.blue },
        Operator = { fg = colors.terra },
        Keyword = { fg = colors.blue },
        Exception = { fg = colors.blue },
        PreProc = { fg = colors.terra },
        Include = { fg = colors.blue },
        Define = { fg = colors.blue },
        Macro = { fg = colors.blue },
        PreCondit = { fg = colors.blue },
        Type = { fg = colors.ochre },
        StorageClass = { fg = colors.ochre },
        Structure = { fg = colors.ochre },
        Typedef = { fg = colors.ochre },
        Special = { fg = colors.terra },
        SpecialChar = { fg = colors.cream },
        Tag = { fg = colors.terra },
        Delimiter = { fg = colors.fg },
        SpecialComment = { fg = colors.grey, italic = true },
        Debug = { fg = colors.blue },
        -- Search
        Search = { fg = colors.bg, bg = colors.ochre },
        IncSearch = { fg = colors.bg, bg = colors.terra },
        -- Git signs
        GitSignsAdd = { fg = colors.ochre },
        GitSignsChange = { fg = colors.blue },
        GitSignsDelete = { fg = colors.terra },
    }

    -- Set highlights
    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
