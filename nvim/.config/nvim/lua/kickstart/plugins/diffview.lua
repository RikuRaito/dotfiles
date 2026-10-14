return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewFileHistory',
    'DiffviewRefresh',
  },
  init = function()
    vim.api.nvim_create_user_command('DO', function(command)
      if command.args == 'BASE' then
        vim.cmd({
          cmd = 'DiffviewOpen',
          args = { 'origin/develop...HEAD' },
        })
        return
      end

      if command.args == 'PR' then
        vim.system({
          'gh',
          'pr',
          'view',
          '--json',
          'baseRefName',
          '--jq',
          '.baseRefName',
        }, { text = true }, function(result)
          vim.schedule(function()
            if result.code ~= 0 then
              local message = vim.trim(result.stderr or '')
              vim.notify(
                message ~= '' and message or 'PRのマージ先ブランチを取得できませんでした',
                vim.log.levels.ERROR
              )
              return
            end

            local base_branch = vim.trim(result.stdout or '')
            if base_branch == '' then
              vim.notify('PRのマージ先ブランチを取得できませんでした', vim.log.levels.ERROR)
              return
            end

            vim.cmd({
              cmd = 'DiffviewOpen',
              args = { 'origin/' .. base_branch .. '...HEAD' },
            })
          end)
        end)
        return
      end

      vim.cmd({
        cmd = 'DiffviewOpen',
        args = command.fargs,
      })
    end, {
      nargs = '*',
      complete = function()
        return { 'BASE', 'PR' }
      end,
      desc = 'Open Diffview with optional Git revisions, develop base, or the current PR base',
    })

    vim.api.nvim_create_user_command('DC', function()
      vim.cmd('DiffviewClose')
    end, {
      desc = 'Close Diffview',
    })
  end,
  keys = {
    {
      '<leader>gd',
      '<cmd>DiffviewOpen<cr>',
      desc = '[G]it [D]iff',
    },
    {
      '<leader>gh',
      '<cmd>DiffviewFileHistory %<cr>',
      desc = '[G]it file [H]istory',
    },
    {
      '<leader>gH',
      '<cmd>DiffviewFileHistory<cr>',
      desc = '[G]it repository [H]istory',
    },
    {
      '<leader>gq',
      '<cmd>DiffviewClose<cr>',
      desc = '[G]it diff [Q]uit',
    },
  },
  opts = {
    hooks = {
      diff_buf_read = function(bufnr)
        vim.bo[bufnr].buflisted = false

        vim.keymap.set('n', 'grd', function()
          vim.lsp.buf.definition({
            on_list = function(options)
              if not options.items or #options.items == 0 then
                vim.notify('定義元が見つかりませんでした', vim.log.levels.INFO)
                return
              end

              vim.fn.setqflist({}, ' ', options)
              vim.cmd('cfirst')
              vim.bo[vim.api.nvim_get_current_buf()].buflisted = true
            end,
          })
        end, {
          buffer = bufnr,
          desc = '[G]oto [D]efinition and add buffer',
        })
      end,
    },
  },
}
