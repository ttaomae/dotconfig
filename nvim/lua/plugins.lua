return {
    -- Treesitter.
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

    -- Colorschemes.
    "rebelot/kanagawa.nvim",
    "edeneast/nightfox.nvim",
    { "navarasu/onedark.nvim", opts = { style = "warmer" } },

    -- Git integrations.
    "tpope/vim-fugitive",
    "airblade/vim-gitgutter",

    -- Editing.
    "tpope/vim-surround",

    -- Status line.
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",

    -- File explorer.
    "preservim/nerdtree",
}
