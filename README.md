venn.nvim
=========

![](https://github.com/jbyuki/gifs/blob/main/Untitled%20Project.gif?raw=true)


Draw ASCII diagrams in Neovim.

Installation
------------

Install using your prefered method:
- [vim-plug](https://github.com/junegunn/vim-plug).
```vim
Plug 'jbyuki/venn.nvim'
```

- [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use "jbyuki/venn.nvim"
```

Usage
-----

* `set virtualedit=all` or `set ve=all`. This will allow you to freely move the cursor in the buffer. (see `help virtualedit`).

* Enter in Visual Block mode using `<C-v>` or `<C-q>`. Select the region where the box should be.

* Invoke `:VBox`. This will draw a rectangle. In case, it has a width or a height of 1, it will draw a line.

Key Mapping
-----------

### Using [hydra.nvim](https://github.com/nvimtools/hydra.nvim)

Any modal keymapping system would work to get additional keys usable for drawing
and moving selections, since there are many options to draw and move around pieces.

#### Draw diagrams

A relative complete configuration to draw diagrams with boxes, lines and arrows
in utf can be found
[in the hydra wiki](https://github.com/nvimtools/hydra.nvim/wiki/Draw-diagrams)
and the more extensive version including explanations
[in this repo wiki](https://github.com/jbyuki/venn.nvim/wiki/Draw-diagrams).

#### Moving selection

Drawing and text repositioning is a frequent operation on more complex
graphics. While `gR` allows to overwrite text from left to right, it does not
allow to move (text) selections around.
Using [mini.move](https://github.com/echasnovski/mini.move)
works with for now main usability restriction of
[no correct fixup after collisions](https://github.com/echasnovski/mini.nvim/issues/838)
and an example configuration can be found
[in the hydra wiki](https://github.com/nvimtools/hydra.nvim/wiki/Move-selection)
and the more extensive version including explanations
[in this repo wiki](https://github.com/jbyuki/venn.nvim/wiki/Move-selection).


### Using toggle command
You can map `:VBox` commands to allow different ways of drawing lines.

Use the following function in your neovim config to toggle drawing lines on `HJKL` directional keys to allow for faster creation of diagrams:

```lua
-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
```
![veenDemo](https://user-images.githubusercontent.com/36175703/130246504-d559f66b-3e2a-4065-90f7-d73bf8147397.gif)

