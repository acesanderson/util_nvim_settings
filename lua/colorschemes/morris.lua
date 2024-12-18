-- morris.lua
local M = {}

-- Color Palette
local colors = {
    bg = "#1D1E3D",           -- Deep Navy
    fg = "#F5E6E0",           -- Cream
    coral = "#FF8A8A",        -- Coral Pink
    blue = "#8BA3C7",         -- Powder Blue
    green = "#626B45",        -- Olive Green
    red = "#E84754",          -- Strawberry Red
    pink = "#FFD1D1",         -- Blush Pink
    sage = "#7A846D",         -- Sage
    none = "NONE"
}

function M.setup()
    -- Reset highlighting
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    -- Set colorscheme name
    vim.g.colors_name = "morris"

    -- Editor highlights
    local highlights = {
        -- UI Elements
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg },
        LineNr = { fg = colors.sage },
        CursorLine = { bg = "#252647" },  -- Slightly lighter than bg
        CursorLineNr = { fg = colors.coral },
        SignColumn = { bg = colors.bg },
        Pmenu = { fg = colors.fg, bg = colors.bg },
        PmenuSel = { fg = colors.bg, bg = colors.coral },
        StatusLine = { fg = colors.coral, bg = colors.bg },
        -- Syntax Highlighting
        Comment = { fg = colors.sage, italic = true },
        Constant = { fg = colors.coral },
        String = { fg = colors.blue },
        Character = { fg = colors.blue },
        Number = { fg = colors.pink },
        Boolean = { fg = colors.coral },
        Float = { fg = colors.pink },
        Identifier = { fg = colors.fg },
        Function = { fg = colors.coral },
        Statement = { fg = colors.red },
        Conditional = { fg = colors.red },
        Repeat = { fg = colors.red },
        Label = { fg = colors.red },
        Operator = { fg = colors.coral },
        Keyword = { fg = colors.red },
        Exception = { fg = colors.red },
        PreProc = { fg = colors.pink },
        Include = { fg = colors.red },
        Define = { fg = colors.red },
        Macro = { fg = colors.red },
        PreCondit = { fg = colors.red },
        Type = { fg = colors.blue },
        StorageClass = { fg = colors.blue },
        Structure = { fg = colors.blue },
        Typedef = { fg = colors.blue },
        Special = { fg = colors.coral },
        SpecialChar = { fg = colors.pink },
        Tag = { fg = colors.coral },
        Delimiter = { fg = colors.fg },
        SpecialComment = { fg = colors.sage, italic = true },
        Debug = { fg = colors.red },
        -- Search
        Search = { fg = colors.bg, bg = colors.coral },
        IncSearch = { fg = colors.bg, bg = colors.red },
        -- Git signs
        GitSignsAdd = { fg = colors.green },
        GitSignsChange = { fg = colors.blue },
        GitSignsDelete = { fg = colors.red },
    }

    -- Set highlights
    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
