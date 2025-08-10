return {
    -- Highlighting.
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "OXY2DEV/markview.nvim" },
        lazy = false,
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "markdown", "markdown_inline",
                    "xml", "html",
                    "lua", "luadoc",
                    "vim", "vimdoc"
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    "norcalli/nvim-colorizer.lua",

    -- Colorschemes.
    { "sainnhe/sonokai", priority = 1000 },
    { "dracula/vim", name = "dracula", priority = 1000 },
    { "folke/tokyonight.nvim", name = "tokyonight", priority = 1000 },
    { "rebelot/kanagawa.nvim", priority = 1000 },
    { "edeneast/nightfox.nvim", priority = 1000 },
    { "navarasu/onedark.nvim", priority = 1000, opts = { style = "warmer" } },

    -- Git integrations.
    "tpope/vim-fugitive",
    "airblade/vim-gitgutter",

    -- Editing.
    "tpope/vim-commentary",
    "tpope/vim-surround",
    "othree/xml.vim",
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        priority = 49,
        opts = {
            preview = {
                modes = { "n", "no", "c", "i", "v", "V" },
                hybrid_modes = { "n", "i", "v", "V" },
            }
        }
    },

    -- Status line.
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",

    -- File explorer.
    "preservim/nerdtree",
}
