return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function ()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  },

 {
 "github/copilot.vim",
    lazy = false,
    config = function() -- Mapping tab is already used in NvChad
      vim.g.copilot_no_tab_map = true; -- Disable tab mapping
      vim.g.copilot_assume_mapped = true; -- Assume that the mapping is already done
    end
},

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
			local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
		end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
			require("dapui").setup()
		end,
  },
 {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },
{
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc", "css", "tsx", "typescript", "javascript"
  		},
  	},
  },
}
