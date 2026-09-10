return {
  {
    'stevearc/oil.nvim',
    opts = { view_options = { show_hidden = true } },
    keys = { { '<leader>e', '<cmd>Oil<cr>', desc = 'File Browser' } },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
        }
      },
      notifier = { enabled = true },
      input = { enabled = true },
    },
    keys = {
      { 
        '<leader>f', 
        function() 
          -- Check if current buffer is Oil; if so, pass its directory, otherwise use cwd
          local path = nil
          if vim.bo.filetype == "oil" then
            path = require("oil").get_current_dir()
          end
          Snacks.picker.files({ cwd = path }) 
        end, 
        desc = 'Find Files (Context Aware)' 
      },
      { 
        '<leader>s', 
        function() 
          local path = nil
          if vim.bo.filetype == "oil" then
            path = require("oil").get_current_dir()
          end
          Snacks.picker.grep({ cwd = path }) 
        end, 
        desc = 'Search Text (Context Aware)' 
      },
      { '<leader>b', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    },
  },
}
