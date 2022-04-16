-- line numbers
vim.wo.number = true

-- transparency
vim.cmd([[
augroup MyColors
autocmd!
autocmd ColorScheme * hi Normal ctermbg=none guibg=none
autocmd ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red
augroup end
]])

-- How to set vim vars
-- vim.opt.undodir = '~/.config/nvim/.undo//'

