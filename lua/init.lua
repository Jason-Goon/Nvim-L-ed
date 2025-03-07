-- init.lua

-- bootstrap lazy.nvim so that plugins are loaded synchronously
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- force synchronous loading of plugins
require("lazy").setup(require("plugins"), { defaults = { lazy = false } })

-- load core settings
require("settings")

-- load custom theme
local theme_path = vim.fn.stdpath("config") .. "/lua/themes/based_theme.lua"
if vim.fn.filereadable(theme_path) == 1 then
    require("lush").apply(require("themes.based_theme"))
else
    print("warning: based_theme.lua not found. using default theme.")
end


-- display ascii art centered on the screen and print info section
local function show_ascii_art()
    if vim.fn.argc() > 0 then return end -- prevent running if files are opened

    local ascii_path = vim.fn.stdpath("config") .. "/asciiart.txt"
    local win_width = vim.api.nvim_win_get_width(0)
    local win_height = vim.api.nvim_win_get_height(0)
    local ascii_art = {}

    if vim.fn.filereadable(ascii_path) == 1 then
        ascii_art = vim.fn.readfile(ascii_path)
    else
        ascii_art = { "⚠ ascii art file not found!" }
    end

    local info_text = {
        "   Nvim L-ed version 1.0.0",
        "     Nvim Lizard Edition",
        " Made By Reptiles, For Reptiles"
    }

    local max_info_length = 0
    for _, line in ipairs(info_text) do
        max_info_length = math.max(max_info_length, #line)
    end
    local info_padding_x = math.max(0, math.floor((win_width - max_info_length) / 2))
    local info_padding_y = math.max(2, math.floor(win_height * 0.1))

    local centered_ascii = {}
    for _ = 1, info_padding_y do
        table.insert(centered_ascii, "")
    end

    for _, line in ipairs(info_text) do
        table.insert(centered_ascii, string.rep(" ", info_padding_x) .. line)
    end

    table.insert(centered_ascii, "")

    local max_line_length = 0
    for _, line in ipairs(ascii_art) do
        max_line_length = math.max(max_line_length, #line)
    end
    local padding_x = math.max(0, math.floor((win_width - max_line_length) / 2))

    for _, line in ipairs(ascii_art) do
        table.insert(centered_ascii, string.rep(" ", padding_x) .. line)
    end

    -- prevent error if buffer is modified or unusable
    if vim.api.nvim_buf_is_valid(0) and vim.bo.buftype == "nofile" then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, centered_ascii)
    end
end

-- setup startup screen
local function setup_ascii_startup()
    if vim.fn.argc() == 0 then
        vim.cmd("enew")
        vim.cmd("setlocal buftype=nofile bufhidden=wipe noswapfile")
        vim.cmd("setlocal nonumber norelativenumber nocursorline")
        vim.cmd("setlocal foldcolumn=0 signcolumn=no")
        vim.cmd("setlocal nowrap")
        show_ascii_art()
    end
end

-- show ascii art at startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = setup_ascii_startup
})

-- update ascii art when window size changes
vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        if vim.bo.buftype == "nofile" and vim.api.nvim_buf_is_valid(0) then
            vim.schedule(function()
                vim.cmd("silent! %d")
                show_ascii_art()
            end)
        end
    end
})