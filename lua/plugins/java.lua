return {
  'nvim-java/nvim-java',
  config = function()
    local java = require('java')

    java.setup({
      spring_boot_tools = {
        enable = false,
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        vim.lsp.enable('jdtls')
      end,
    })
  end,
}
