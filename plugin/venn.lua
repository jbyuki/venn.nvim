-- to have a clean 100% lua statistics in Github ;) I know it's perfectionism
vim.cmd [[command! -range VBox lua require"venn".draw_box("s")]]
vim.cmd [[command! -range VBoxD lua require"venn".draw_box("d")]]
vim.cmd [[command! -range VBoxH lua require"venn".draw_box("b")]]

vim.cmd [[command! -range VBoxO lua require"venn".draw_box_over("s")]]
vim.cmd [[command! -range VBoxDO lua require"venn".draw_box_over("d")]]
vim.cmd [[command! -range VBoxHO lua require"venn".draw_box_over("b")]]

vim.cmd [[command! -range VBoxR lua require"venn".draw_box("r")]]
vim.cmd [[command! -range VDiv lua require"venn".div_box()]]
vim.cmd [[command! -range VAlignL lua require"venn".align_box("left")]]
vim.cmd [[command! -range VAlignC lua require"venn".align_box("center")]]
vim.cmd [[command! -range VAlignR lua require"venn".align_box("right")]]

vim.cmd [[command! -range VFill lua require"venn".fill_box()]]
vim.cmd [[command! -range VErase lua require"venn".erase_box()]]
