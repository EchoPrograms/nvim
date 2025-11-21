vim.g.mapleader = " "

-- Built in
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>F', builtin.find_files, {})

vim.keymap.set('n', '<leader>ff', builtin.git_files, {})

vim.keymap.set('n', '<leader>G', builtin.live_grep, {})

-- Nav
vim.keymap.set("i", "jk", "<Esc>", {})


-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)


vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end)
vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end)
vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) end)

-- Undo tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)


-- Vim Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)

    vim.keymap.set("n", "<leader>nd", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>pd", function() vim.diagnostic.goto_prev() end, opts)

    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end,
})

