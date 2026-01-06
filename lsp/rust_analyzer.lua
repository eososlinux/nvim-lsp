return {
  cmd = { "rust-analyzer" },

--   root_dir = function()
--     return vim.fs.root(0, {
--       "Cargo.toml",
--       "rust-project.json",
--       ".git",
--     }) or vim.loop.cwd()
--   end,
--
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--     checkOnSave = {
--       command = "clippy",
--     },
--     proMacro = {
--       enable = true,
--     },
--   },
-- },
}
