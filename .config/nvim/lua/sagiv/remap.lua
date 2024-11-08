-- some old habits that die hard. especially shift-movement keys
--vim.cmd("runtime mswin.vim")

-- \pv to open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- remap ctrl-a/e to move to start/end of line
vim.keymap.set("i", "<C-A>", "<Home>")
vim.keymap.set("n", "<C-A>", "<Home>")
vim.keymap.set("i", "<C-E>", "<End>")
vim.keymap.set("n", "<C-E>", "<End>")
vim.keymap.set("i", "<F1>", "<ESC>")
vim.keymap.set("n", "<F1>", "<ESC>")

-- remap ctrl-arrow keys to move between windows
vim.keymap.set("n", "<C-Left>", "<C-W>h")
vim.keymap.set("n", "<C-Right>", "<C-W>l")
vim.keymap.set("n", "<C-Up>", "<C-W>k")
vim.keymap.set("n", "<C-Down>", "<C-W>j")

-- remap cmd-c/v to copy/paste to system clipboard
vim.keymap.set("v", "<D-c>", '"+y')
vim.keymap.set("n", "<D-c>", '"+y')
vim.keymap.set("s", "<D-c>", '"+y')
vim.keymap.set("n", "<D-v>", '"+p')
vim.keymap.set("v", "<D-v>", '"+p')
vim.keymap.set("s", "<D-v>", '"+p')

vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("n", "<C-c>", '"+y')
vim.keymap.set("s", "<C-c>", '"+y')
vim.keymap.set("n", "<C-v>", '"+p')
vim.keymap.set("v", "<C-v>", '"+p')
vim.keymap.set("s", "<C-v>", '"+p')


-- Yank selected text to the system clipboard with Cmd+C in normal, visual, and select mode
vim.api.nvim_set_keymap('v', '<D-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<D-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<D-c>', '"+y', { noremap = true, silent = true })

-- Paste from the system clipboard with Cmd+V in normal, visual, and select mode
vim.api.nvim_set_keymap('n', '<D-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<D-v>', '"+p', { noremap = true, silent = true })

-- remap leader-f to EslintFixall
vim.keymap.set("n", "<leader>f", ":EslintFixAll<CR>")

-- remap leader-d to open diagnostic float
vim.keymap.set("n", "<leader>D", function ()
    vim.diagnostic.open_float()
end)

