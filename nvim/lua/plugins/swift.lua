return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "swift" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          mason = false, -- sourcekit-lsp ships with the Swift/Xcode toolchain, not mason
        },
      },
    },
  },
}
