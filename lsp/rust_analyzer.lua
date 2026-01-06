return {
  cmd = { "rust-analyzer" },

--   root_dir = function()
--     return vim.fs.root(0, {
--       "Cargo.toml",
--       ".git",
--     }) or vim.loop.cwd()
--   end,
-- --
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--     },
--   },
}
