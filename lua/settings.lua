-- settings.lua

-- basic neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.mouse = "a"

-- leader key
vim.g.mapleader = " "

-- lsp and autocompletion
local lspconfig = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "rust_analyzer", "clangd", "pyright", "ts_ls", "html", "cssls" }
})

local servers = { "rust_analyzer", "clangd", "pyright", "ts_ls", "html", "cssls" }
for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = cmp_capabilities
  })
end

-- nvim-tree setup
require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  filters = {
    custom = { ".git", "node_modules", ".cache" }
  },
  git = {
    enable = true,
    ignore = false,
  },
})

-- bind <leader>e (space + e) to toggle nvimtree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- telescope search setup
local telescope = require("telescope")
telescope.setup({
    defaults = {
        file_ignore_patterns = {"node_modules", "%.git/"},
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    }
})

-- bind <leader>f (space + f) to open telescope find files
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- bind <leader>g (space + g) to open telescope live grep
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true })


-- toggle copilot
vim.api.nvim_set_keymap("n", "<leader>co", ":Copilot status<CR>", { noremap = true, silent = true })

-- vimtex configuration (latex support)
vim.g.vimtex_view_method = "mupdf"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode = 0

-- function to create a new latex project and open it in neovim
local function create_project(project_type, name)
  local root = vim.fn.stdpath("config") .. "/math-templates/"
  local dest = vim.fn.expand("~/Documents/" .. project_type .. "/" .. name)
  local new_file = dest .. "/" .. name .. ".tex"

  -- ensure the destination directory exists
  os.execute("mkdir -p " .. dest)

  -- copy all template files into the destination
  os.execute("cp -r " .. root .. "* " .. dest)

  -- rename the personal template to match the project name
  os.execute("mv " .. dest .. "/personal_template.tex " .. new_file)

  -- notify the user
  print("created " .. project_type .. " project: " .. dest)

  -- switch neovim to the new project directory
  vim.cmd("cd " .. dest)
  print("switched to " .. dest)

  -- open the renamed template in neovim
  vim.cmd("edit " .. new_file)

  -- start latex compilation in the background
  vim.cmd("VimtexCompile")
end

-- commands to create different project types
vim.api.nvim_create_user_command("NewMathProject", function(args)
  create_project("math", args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("NewNotes", function(args)
  create_project("notes", args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("NewAssignment", function(args)
  create_project("assignments", args.args)
end, { nargs = 1 })
