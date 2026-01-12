return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local servers = {
      clangd = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      },
      jdtls = {},
    }

    local ensure = {}
    for name, _ in pairs(servers) do
      table.insert(ensure, name)
    end

    require("mason-lspconfig").setup({
      ensure_installed = ensure,
      automatic_installation = true,
    })

    for name, opts in pairs(servers) do
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
}
