return { 'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = function()
    require("nvim-tree").setup {
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      hijack_netrw = false,
    }
  end
}
