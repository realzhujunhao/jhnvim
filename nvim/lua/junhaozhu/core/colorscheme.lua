local status, _ = pcall(vim.cmd, "colorscheme kanagawa-dragon")
if not status then
	print("Colorscheme not found!")
	return
end
