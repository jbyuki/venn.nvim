venn.nvim
=========

![](https://github.com/jbyuki/gifs/blob/main/Untitled%20Project.gif?raw=true)


Draw ASCII diagrams in Neovim.

Installation
------------

Install using your prefered method for example using [vim-plug](https://github.com/junegunn/vim-plug).
```vim
Plug 'jbyuki/venn.nvim'
```

[Packer](https://github.com/wbthomason/packer.nvim)
```lua
use "jbyuki/venn.nvim"
```

Usage
-----

* `set virtualedit=all` or `set ve=all`. This will allow you to freely move the cursor in the buffer. (see `help virtualedit`).

* Enter in Visual Block mode using `<C-v>`. Select the region where the box should be.

* Invoke `:VBox`. This will draw a rectangle. In case, it has a width or a height of 1, it will draw a line.
