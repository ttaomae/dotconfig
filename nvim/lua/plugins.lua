return {
    -- Highlighting.
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    "norcalli/nvim-colorizer.lua",

    -- Colorschemes.
    { "dracula/vim", name = "dracula", priority = 1000 },
    { "rebelot/kanagawa.nvim", priority = 1000 },
    { "edeneast/nightfox.nvim", priority = 1000 },
    { "navarasu/onedark.nvim", priority = 1000, opts = { style = "warmer" } },

    -- Git integrations.
    "tpope/vim-fugitive",
    "airblade/vim-gitgutter",

    -- Editing.
    "tpope/vim-commentary",
    "tpope/vim-surround",

    -- Status line.
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",

    -- File explorer.
    "preservim/nerdtree",
}
