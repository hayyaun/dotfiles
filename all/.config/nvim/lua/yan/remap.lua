print("Loading remap")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore command" })
vim.keymap.set("n", "<leader>ptn", vim.cmd.tabnew, { desc = "tabnew command" })
-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeShow, { desc = "show undotree" })
vim.keymap.set("n", "<leader>pc", function()
	vim.cmd("below terminal")
end, { desc = "open terminal below" })
