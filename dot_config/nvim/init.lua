-- vim:foldmethod=marker

-- lazy.nvmi {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- Plugins {{{
require("lazy").setup({
    {
        "ibhagwan/fzf-lua",
        keys = {
            {"<C-x>P", ":FzfLua builtin<CR>",   mode = "n"},
            {"<C-x>p", ":FzfLua git_files<CR>", mode = "n"},
            {"<C-x>b", ":FzfLua buffers<CR>",   mode = "n"},
            {"<C-x>f", ":FzfLua live_grep { cmd = 'git grep --line-number --column --color=always' }<CR>", mode = "n"},
        },
    },
    {
      "folke/tokyonight.nvim",
      lazy     = false,
      priority = 1000,
      opts     = {
          transparent = true,
          styles = {
              sidebars = "transparent",
              floats = "transparent",
          },
      },
    },
    {
        "Vonr/align.nvim",
        branch = "v2",
        lazy   = true,
        init   = function()
            local NS = { noremap = true, silent = true }
            -- Aligns to 1 character
            vim.keymap.set(
                "x",
                "aa",
                function()
                    require("align").align_to_char({
                        length = 1,
                    })
                end,
                NS
            )
            -- Aligns to a string with previews
            vim.keymap.set(
                'x',
                'aw',
                function()
                    require'align'.align_to_string({
                        preview = true,
                        regex   = false,
                    })
                end,
                NS
            )
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event   = "VeryLazy",
        config  = function()
            require("nvim-surround").setup({}) -- Configuration here, or leave empty to use defaults
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            mappings = {
                basic = true,
                extra = true, -- `gcA`: Add comment at the end of line
            },
        },
    },
    "fatih/vim-go",
    "github/copilot.vim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
        "neoclide/coc.nvim",
        branch = "release",
        build = "npm ci",
        config = function()
            vim.g.coc_global_extensions = {
                "coc-spell-checker",
                "coc-yaml",
                "coc-tsserver",
                "coc-sql",
                "coc-sh",
                "coc-rust-analyzer",
                "coc-markdownlint",
                "coc-json",
                "coc-go",
            }
        end
    },
    "hashivim/vim-terraform",
})
-- }}}

vim.g.copilot_filetypes = {
    gitcommit = true,
    markdown  = true,
    yaml      = true,
    text      = true,
    rust      = true,
}

vim.cmd[[colorscheme tokyonight-night]]

-- Basic Settings {{{
vim.opt.ambiwidth   = "double"
vim.opt.autoindent  = true
vim.opt.autoread    = true
vim.opt.backspace   = "2"
vim.opt.clipboard   = "unnamedplus"
vim.opt.completeopt = "menuone"
vim.opt.cursorline  = true
vim.opt.display     = "lastline"
vim.opt.expandtab   = true
vim.opt.hidden      = true
vim.opt.ignorecase  = true
vim.opt.incsearch   = true
vim.opt.list        = true
vim.opt.listchars   = {
    tab      = "> ",
    trail    = "~",
    extends  = ">",
    precedes = "<",
    nbsp     = "%"
}
vim.opt.matchtime     = 1
vim.opt.swapfile      = false
vim.opt.number        = true
vim.opt.pumheight     = 10
vim.opt.scrolloff     = 999  -- always keep the cursor centered. Be careful with fzf_layout window compatibility
vim.opt.shiftwidth    = 4
vim.opt.showmatch     = true
vim.opt.smartcase     = true
vim.opt.softtabstop   = 4
vim.opt.splitbelow    = true
vim.opt.splitright    = true
vim.opt.tabstop       = 4
vim.opt.updatetime    = 300
vim.opt.wildmenu      = true
vim.opt.wildmode      = "longest:full,full"
vim.opt.termguicolors = true
vim.opt.winblend      = 0 -- ウィンドウの不透明度
vim.opt.pumblend      = 0 -- ポップアップメニューの不透明度
-- }}}

-- Key Mappings {{{
-- Leader to <Space>
vim.g.mapleader = " "
-- Map <ESC><ESC> to clear search highlighting
vim.keymap.set("n", "<ESC><ESC>", ":nohl<CR>")
-- Map ; to :
vim.keymap.set("n", ";", ":", { noremap = true })
-- Map Y to y$ (yank to end of line)
vim.keymap.set("n", "Y", "y$", { noremap = true })
-- Split window and explore current directory
vim.keymap.set("n", "\\E", ":vsplit<CR>:e %:p:h<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "\\e", ":e %:p:h<CR>",            { noremap = true, silent = true })
-- Toggle line numbers
vim.keymap.set("n", "\\n", ":set number!<CR>", { noremap = true, silent = true })
-- Emacs-like keybindings for insert mode
vim.keymap.set("i", "<C-p>", "<Up>",      { noremap = true })
vim.keymap.set("i", "<C-n>", "<Down>",    { noremap = true })
vim.keymap.set("i", "<C-f>", "<Right>",   { noremap = true })
vim.keymap.set("i", "<C-b>", "<Left>",    { noremap = true })
vim.keymap.set("i", "ƒ",     "<C-Right>", { noremap = true }) -- Alt-f
vim.keymap.set("i", "∫",    "<C-Left>",  { noremap = true }) -- Alt-b
vim.keymap.set("i", "<C-a>", "<Home>",    { noremap = true })
vim.keymap.set("i", "<C-e>", "<End>",     { noremap = true })
vim.keymap.set("i", "<C-d>", "<Del>",     { noremap = true })
vim.keymap.set("i", "<C-h>", "<BS>",      { noremap = true })
vim.keymap.set("i", "<C-k>", "<C-o>C",    { noremap = true })
-- vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]],     { expr = true })
-- vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
vim.keymap.set("i", "<C-p>",   [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"]],      { expr = true })
vim.keymap.set("i", "<C-n>",   [[coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"]],      { expr = true })
vim.keymap.set("i", "<Tab>",   [[coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"]],    { expr = true })
vim.keymap.set("i", "<Enter>", [[coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"]],  { expr = true })
-- Emacs-like keybindings for command-line mode
vim.keymap.set("c", "<C-p>", "<Up>",    { noremap = true })
vim.keymap.set("c", "<C-n>", "<Down>",  { noremap = true })
vim.keymap.set("c", "<C-f>", "<Right>", { noremap = true })
vim.keymap.set("c", "<C-b>", "<Left>",  { noremap = true })
vim.keymap.set("c", "<C-a>", "<Home>",  { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>",   { noremap = true })
vim.keymap.set("c", "<C-d>", "<Del>",   { noremap = true })
vim.keymap.set("c", "<C-h>", "<BS>",    { noremap = true })
-- Command line kill line (Ctrl-k)
vim.keymap.set("c", "<C-k>", [[<C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>]], { noremap = true })
-- Buffer delete mapping
vim.keymap.set("n", "<Leader>bd", ":bdelete<CR>", { noremap = true, silent = true })
-- Coc jump to definition with vertical split
vim.keymap.set("n", "gv", "<Cmd>call CocAction('jumpDefinition', 'vsplit')<CR>", { noremap = true, silent = true })
-- }}}

local plugin_statues = table.concat({
  "%{coc#status()}",
  "%{fugitive#statusline()}",
}, " ")
vim.o.statusline = table.concat({
  "%<", -- Truncate the line to the left
  "%f", -- Path to the file in the buffer
  " ",
  "%y", -- Filetype
  "[%{&fileformat}]", -- File format
  "%h", -- Help buffer flag "[Help]"
  "%m", -- Modified flag "[+], [-]"
  "%r", -- Readonly flag "[RO]"
  "%=", -- Right align
  plugin_statues,
  " ",
  "%-14.(%l,%c%V%)", -- Line number, Virtual column number
  "  ",
  "%b(0x%B)", -- Value of character and hexdecimal
  " ",
  "%P", -- Percentage through the file
})

local group = vim.api.nvim_create_augroup("custom_filetypes", { clear = true })

local function set_ft(pattern, ft)
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = pattern,
        group = group,
        callback = function() vim.bo.filetype = ft end,
    })
end

-- for Terraform {{{
set_ft("*.hcl", "hcl")
set_ft({ ".terraformrc", "terraform.rc" }, "hcl")
set_ft({ "*.tf", "*.tfvars" }, "terraform")
set_ft({ "*.tfstate", "*.tfstate.backup" }, "json")

vim.g.terraform_fmt_on_save = 1
vim.g.terraform_align       = 1
-- }}}
