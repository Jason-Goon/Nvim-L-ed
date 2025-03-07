return {
    -- file browser with icons
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  
    -- treesitter for better syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  
    -- lsp configuration and autocompletion
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim", config = function() require("mason").setup() end },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" } },
  
    -- git integration
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },
  
    -- based theme neovim port dependency
    { "rktjmp/lush.nvim" },
  
    -- nicer interface
    { "nvim-lualine/lualine.nvim" },
  
    -- latex support (always enabled)
    {
        "lervag/vimtex",
        config = function()
            vim.g.vimtex_view_method = "zathura"  -- set pdf viewer
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_quickfix_mode = 0
        end
    },
  
    -- github copilot (always enabled)
    {
        "github/copilot.vim",
        config = function()
            vim.api.nvim_set_keymap("n", "<leader>co", ":Copilot toggle<CR>", { noremap = true, silent = true })
        end
    },
  
    -- telescope for file navigation and fuzzy finding
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }
  }
  