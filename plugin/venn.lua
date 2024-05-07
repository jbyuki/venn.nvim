-- to have a clean 100% lua statistics in Github ;) I know it's perfectionism
vim.cmd [[command! -range VBox lua require"venn".draw_box_utf("s")]]
vim.cmd [[command! -range VBoxD lua require"venn".draw_box_utf("d")]]
vim.cmd [[command! -range VBoxH lua require"venn".draw_box_utf("b")]]

vim.cmd [[command! -range VBoxO lua require"venn".draw_box_utf_over("s")]]
vim.cmd [[command! -range VBoxDO lua require"venn".draw_box_utf_over("d")]]
vim.cmd [[command! -range VBoxHO lua require"venn".draw_box_utf_over("b")]]

vim.cmd [[command! -range VFill lua require"venn".fill_box_utf()]]