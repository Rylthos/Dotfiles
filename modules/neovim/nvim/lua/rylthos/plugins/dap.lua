return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      }
    }

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          local args_string = vim.fn.input('Arguments: ')
          return vim.split(args_string, " +")
        end;
      }
    }

    vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
    vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
    vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
    vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
    vim.keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end)
    vim.keymap.set("n", "<leader>B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
    vim.keymap.set("n", "<leader>lp", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
    vim.keymap.set("n", "<leader>dr", function() require("dap").repl_open() end)
    vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end)

    require("dapui").setup({})
  end
}
