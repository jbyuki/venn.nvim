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

* Enter in Visual Block mode using `<C-v>`. Select the region where the box should be.

* Invoke `:VBox`. This will draw a rectangle. In case, it has a width or a height of 1, it will draw a line.

Key Mapping
-----------

### Using [Hydra](https://github.com/anuvyklack/hydra.nvim)
```lua
local hint = [[
^^^^    Draw
^^^^-------------
Arrows: _<C-h>_ _<C-j>_ _<C-k>_ _<C-l>_
Box (select box with visual block first): _<C-f>_
^ ^				_<Esc>_: exit
]]

Hydra({
	name = 'Draw',
	hint = hint,
	config = {
		color = 'pink',
		invoke_on_body = true,
		hint = {
			position = 'bottom',
			border = 'rounded'
		},
		on_enter = function()
			vim.opt_local.virtualedit = 'all'
		end,
		on_exit = function()
			vim.opt_local.virtualedit = ''
		end
	},
	mode = {'n'},
	body = '<leader>draw',
	heads = {
		{ '<C-h>', '<C-v>h:VBox<CR>' },
		{ '<C-j>', '<C-v>j:VBox<CR>' },
		{ '<C-k>', '<C-v>k:VBox<CR>' },
		{ '<C-l>', '<C-v>l:VBox<CR>' },
		{ '<C-f>', ':VBox<CR>', { mode = 'v' }},
		{ '<Esc>', nil, { exit = true, nowait = true } },
	}
})
```

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
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
```
![veenDemo](https://user-images.githubusercontent.com/36175703/130246504-d559f66b-3e2a-4065-90f7-d73bf8147397.gif)

