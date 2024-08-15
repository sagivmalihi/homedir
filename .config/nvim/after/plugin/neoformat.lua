-- in vim:
-- let g:neoformat_try_node_exe = 1

vim.g.neoformat_try_node_exe = 1

-- autocmd BufWritePre,TextChanged,InsertLeave *.js Neoformat

vim.cmd [[autocmd BufWritePre,TextChanged,InsertLeave *.js Neoformat]]
