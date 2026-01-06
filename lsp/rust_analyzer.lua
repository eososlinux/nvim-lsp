return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },

  root_dir = function(bufnr)
    return vim.fs.root(bufnr, {
      "Cargo.toml",
      "rust-project.json",
      ".git",
    }) or vim.fn.getcwd()
  end,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
