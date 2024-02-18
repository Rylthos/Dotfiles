vim.api.nvim_create_user_command("ClearRegisters", function()
	local reg = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
	reg:gsub(".", function(c)
		-- Clear Registers
		vim.fn.setreg(c, "")
	end)
end, {})
