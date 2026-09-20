vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<A-CR>", "o<Esc>", { desc = "Insert a line below" })
vim.keymap.set("n", "<S-A-CR>", "O<Esc>", { desc = "Insert a line above" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "increment numbers" })
keymap.set("n", "<leader>-", "<C-a>", { desc = "decrement numbers" })

--windows management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<cmd>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "yp", "<yyp>", { desc = "Duplicate a line" })
