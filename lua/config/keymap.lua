-- keymap
--------------------------------------------------------------------------------
-- Navigate visual lines
vim.keymap.set({ "n", "x" }, "j", "gj", { desc = "Navigate down (visual line)" })
vim.keymap.set({ "n", "x" }, "k", "gk", { desc = "Navigate up (visual line)" })
vim.keymap.set({ "n", "x" }, "<Down>", "gj", { desc = "Navigate down (visual line)" })
vim.keymap.set({ "n", "x" }, "<Up>", "gk", { desc = "Navigate up (visual line)" })
vim.keymap.set("i", "<Down>", "<C-\\><C-o>gj", { desc = "Navigate down (visual line)" })
vim.keymap.set("i", "<Up>", "<C-\\><C-o>gk", { desc = "Navigate up (visual line)" })

-- Move Lines
vim.keymap.set({ "n", "x" }, "<M-S-Up>", ":move -2<cr>", { desc = "Move Line Up" })
vim.keymap.set({ "n", "x" }, "<M-S-Down>", ":move +1<cr>", { desc = "Move Line Down" })
vim.keymap.set("i", "<M-S-Up>", "<C-o>:move -2<cr>", { desc = "Move Line Up" })
vim.keymap.set("i", "<M-S-Down>", "<C-o>:move +1<cr>", { desc = "Move Line Down" })

-- Easier interaction with the system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard after the cursor position" })
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste from system clipboard before the cursor position" })

-- Navigating buffers
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Switch to alternate buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>", { desc = "Previous buffer" })

-- Ctrl-L redraws the screen by default. Now it will also toggle search highlighting.
vim.keymap.set("n", "<C-l>", ":set hlsearch!<cr><C-l>", { desc = "Toggle search highlighting" })

-- Toggle visible whitespace characters
vim.keymap.set("n", "<leader>l", ":listchars!<cr>", { desc = "Toggle [l]istchars" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Quickly source current file / execute Lua code
vim.keymap.set("n", "<leader>xx", "<Cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>x", "<Cmd>:.lua<CR>", { desc = "Lua: execute current line" })
vim.keymap.set("v", "<leader>x", "<Cmd>:lua<CR>", { desc = "Lua: execute current selection" })

local builtin = require("telescope.builtin")

-- Archivos
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- LSP
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "LSP definitions" })
vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "LSP implementations" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
