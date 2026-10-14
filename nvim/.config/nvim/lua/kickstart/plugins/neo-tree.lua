-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = true,
  keys = {
    {
      '\\',
      ':Neotree toggle<CR>',
      desc = 'Toggle NeoTree',
      silent = true,
    },
  },
  opts = {
    event_handlers = {
      {
        event = 'file_opened',
        handler = function()
          require('neo-tree.command').execute({ action = 'close' })
        end,
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = '\u{f07b}',
        folder_open = '\u{f07c}',
        folder_empty = '\u{f114}',
        folder_empty_open = '\u{f115}',
      },
    },
    filesystem = {
      find_by_full_path_words = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
      },
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ['<bs>'] = 'noop',
        },
      },
    },
  },
}
