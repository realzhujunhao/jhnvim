-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- dependency of other plugins
	use("folke/tokyonight.nvim")
	use({ "bluz71/vim-nightfly-colors", as = "nightfly" })
	use({ "catppuccin/nvim", as = "catppuccin" })
    use({ "ellisonleao/gruvbox.nvim" })
    use({ "EdenEast/nightfox.nvim" })
    use("rebelot/kanagawa.nvim")
    use("vim-airline/vim-airline")
    use("vim-airline/vim-airline-themes")

	use("christoomey/vim-tmux-navigator") -- split window navigation
	use("szw/vim-maximizer") -- maximize & restore current window
	use("tpope/vim-surround") -- ysw" = surround a word with quotes   ds" = undo
	use("vim-scripts/ReplaceWithRegister") -- yw = copy    grw = replace by copy
	use("numToStr/Comment.nvim") -- gcc = comment/uncomment line    gc5j = comment 5 lines
	use("nvim-tree/nvim-tree.lua") -- file explorer
	use("kyazdani42/nvim-web-devicons") -- icons
	use("nvim-lualine/lualine.nvim") --statusline
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- configure lsp
	use("neovim/nvim-lspconfig")
	use({ "neoclide/coc.nvim", branch = "release" })

    -- copilot
--    use("github/copilot.vim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
