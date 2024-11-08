return {
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "jay-babu/mason-null-ls.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_defaults = lspconfig.util.default_config

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
          "lua_ls",
          "taplo",
          "bashls",
          "clangd",
          "pyright",
          "tailwindcss",
          "mdx_analyzer",
          "ts_ls",
        },
        handlers = {
          function(server)
            lspconfig[server].setup({
              capabilities = capabilities,
            })
          end,
        },
      })

      -- band-aid for multiple encoding warn
      lspconfig.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
          -- vim.keymap.set('n', '<C-f>', function()
          -- vim.lsp.buf.format { async = true }
          --end, opts)
        end,
      })
      local cmp = require("cmp")
      local ls = require("luasnip")

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        snippet = {
          expand = function(args)
            ls.lsp_expand(args.body)
          end,
        },
        window = {},
      })
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      ls.add_snippets("lua", {
        s("hello", {
          t('print("hello, '),
          i(1),
          t('")'),
        }),
      })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/custom/code_snippets" } })

      require("mason-null-ls").setup({
        ensure_installed = { "black", "latexindent" },
      })

      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
        },
      })
    end,
  },
}
