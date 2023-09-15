vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
local sino = {silent = true, noremap = true}
-- TAB          select next completion
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
-- ENTER        apply selected completion
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
-- LEADER-t     toggle terminal
keyset("n", "<leader>t", "<Plug>(coc-terminal-toggle)", sino)
vim.api.nvim_set_keymap('t', ';t', [[<C-\><C-n><Plug>(coc-terminal-toggle)]], sino)
-- LEADER-f     format document
keyset("n", "<leader>f", "<CMD>call CocAction('format')<CR>", sino)
-- LEADER-rn    rename specifier
keyset("n", "<leader>rn", "<Plug>(coc-rename)", sino)
-- g-d          goto definition
keyset("n", "gd", "<Plug>(coc-definition)", sino)
-- g-i          goto implementation
keyset("n", "gi", "<Plug>(coc-implementation)", sino)
-- LEADER-doc   show documentation
keyset("n", "<leader>doc", '<CMD>lua _G.show_docs()<CR>', sino)


-- RUST ONLY
-- LEADER-rs    restart lsp
keyset("n", "<leader>rs", "<CMD>CocCommand rust-analyzer.reload<CR>", sino)
-- LEADER-k     move item up
keyset("n", "<leader>k", "<CMD>CocCommand rust-analyzer.moveItemUp<CR>", sino)
-- LEADER-j     move item down
keyset("n", "<leader>j", "<CMD>CocCommand rust-analyzer.moveItemDown<CR>", sino)
-- LEADER-l     join lines
keyset("n", "<leader>l", "<CMD>CocCommand rust-analyzer.joinLines<CR>", sino)

-- TS ONLY
-- LEADER-rs    restart lsp
keyset("n", "<leader>rst", "<CMD>CocCommand tsserver.restart<CR>", sino)

-- PYTHON ONLY
keyset("n", "<leader>rsp", "<CMD>CocCommand pyright.restartserver<CR>", sino)
