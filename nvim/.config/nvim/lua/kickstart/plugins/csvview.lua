return {
  'hat0uma/csvview.nvim',
  cmd = {
    'CsvViewEnable',
    'CsvViewDisable',
    'CsvViewToggle',
    'CsvViewInfo',
  },
  keys = {
    {
      '<leader>cv',
      '<cmd>CsvViewToggle<cr>',
      desc = '[C]SV [V]iew toggle',
    },
  },
  opts = {
    view = {
      display_mode = 'border',
      header_lnum = true,
      sticky_header = {
        enabled = true,
        separator = '─',
      },
    },
    keymaps = {
      textobject_field_inner = { 'if', mode = { 'o', 'x' } },
      textobject_field_outer = { 'af', mode = { 'o', 'x' } },
      jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
      jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
      jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
      jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
    },
  },
}
