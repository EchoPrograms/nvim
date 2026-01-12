vim.g.mapleader = " "

-- QoL 
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")

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

    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)

    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end,
})


-- CodeCompanion keymaps (all begin with <leader>c)

-- Model selection menu for CodeCompanion
vim.keymap.set("n", "<leader>cm", function()
  -- Query Ollama models from local API
  local function get_ollama_models()
    local handle = io.popen("curl -s http://localhost:11434/api/tags")
    if not handle then return {} end
    local result = handle:read("*a")
    handle:close()
    local models = {}
    if result and result ~= "" then
      local ok, json = pcall(vim.fn.json_decode, result)
      if ok and type(json) == "table" then
        for _, m in ipairs(json.models or {}) do
          table.insert(models, { name = "Ollama (" .. m.name .. ")", model = "ollama-" .. m.name })
        end
      end
    end
    return models
  end

  local models = {
    { name = "Copilot (gpt-3.5-turbo)", model = "copilot-gpt-3.5-turbo" },
    { name = "Copilot (gpt-4)", model = "copilot-gpt-4" },
  }
  -- Add Ollama models from Docker
  for _, m in ipairs(get_ollama_models()) do
    table.insert(models, m)
  end

  local choices = {}
  for i, m in ipairs(models) do
    table.insert(choices, string.format("%d. %s", i, m.name))
  end

  vim.ui.select(choices, { prompt = "Select CodeCompanion Model:" }, function(choice, idx)
    if choice and idx then
      vim.g.codecompanion_model = models[idx].model
      vim.notify("CodeCompanion model set to " .. models[idx].name, vim.log.levels.INFO)
    end
  end)
end, { noremap = true, silent = true })

-- Inline assistant
vim.keymap.set("n", "<leader>ci", "<cmd>CodeCompanion<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ci", "<cmd>CodeCompanion<cr>", { noremap = true, silent = true })

-- Chat
vim.keymap.set("n", "<leader>cn", "<cmd>CodeCompanionChat<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Refresh chat cache
vim.keymap.set("n", "<leader>cr", "<cmd>CodeCompanionChat RefreshCache<cr>", { noremap = true, silent = true })

-- Actions palette
vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })

-- Prompt library examples
vim.keymap.set("n", "<leader>ce", "<cmd>CodeCompanion /explain<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cf", "<cmd>CodeCompanion /fix<cr>", { noremap = true, silent = true })
