-- morris-botanical.lua
local M = {}

-- Color Palette derived from the botanical pattern
local colors = {
    bg = "#1B2A2F",           -- Deep teal-navy background
    fg = "#E8EDE9",           -- Light mint cream
    sage = "#A5C0A7",         -- Sage green from large leaves
    mint = "#C5DAC7",         -- Mint green highlights
    pink = "#E6B3B3",         -- Soft pink from carnations
    yellow = "#D6C48E",       -- Muted yellow from small flowers
    red = "#CD8B8B",          -- Deeper pink-red from flower details
    brown = "#8B7355",        -- Brown from stems
    none = "NONE"
}

function M.setup()
    -- Reset highlighting
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    -- Set colorscheme name
    vim.g.colors_name = "morris-botanical"

    -- Editor highlights
    local highlights = {
        -- UI Elements
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg },
        LineNr = { fg = colors.sage },
        CursorLine = { bg = "#243338" },  -- Slightly lighter than bg
        CursorLineNr = { fg = colors.pink },
        SignColumn = { bg = colors.bg },
        Pmenu = { fg = colors.fg, bg = colors.bg },
        PmenuSel = { fg = colors.bg, bg = colors.sage },
        StatusLine = { fg = colors.sage, bg = colors.bg },
        -- Syntax Highlighting
        Comment = { fg = colors.sage, italic = true },
        Constant = { fg = colors.pink },
        String = { fg = colors.mint },
        Character = { fg = colors.mint },
        Number = { fg = colors.yellow },
        Boolean = { fg = colors.pink },
        Identifier = { fg = colors.fg },
        Function = { fg = colors.sage },
        Statement = { fg = colors.red },
        Conditional = { fg = colors.red },
        Repeat = { fg = colors.red },
        Label = { fg = colors.red },
        Operator = { fg = colors.pink },
        Keyword = { fg = colors.red },
        Exception = { fg = colors.red },
        PreProc = { fg = colors.pink },
        Include = { fg = colors.red },
        Define = { fg = colors.red },
        Macro = { fg = colors.red },
        PreCondit = { fg = colors.red },
        Type = { fg = colors.mint },
        StorageClass = { fg = colors.mint },
        Structure = { fg = colors.mint },
        Typedef = { fg = colors.mint },
        Special = { fg = colors.pink },
        SpecialChar = { fg = colors.yellow },
        Tag = { fg = colors.pink },
        Delimiter = { fg = colors.fg },
        SpecialComment = { fg = colors.sage, italic = true },
        Debug = { fg = colors.red },
        -- Search
        Search = { fg = colors.bg, bg = colors.sage },
        IncSearch = { fg = colors.bg, bg = colors.pink },
        -- Git signs
        GitSignsAdd = { fg = colors.sage },
        GitSignsChange = { fg = colors.yellow },
        GitSignsDelete = { fg = colors.red },
    }

    -- Set highlights
    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
