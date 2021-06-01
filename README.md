venn.nvim
=========

[![Untitled-Project.gif](https://i.postimg.cc/mkGpFr2c/Untitled-Project.gif)](https://postimg.cc/2b27srWm)

Draw ASCII diagrams in Neovim.

Installation
------------

Install using your prefered method for example using [vim-plgu](https://github.com/junegunn/vim-plug).

```vim
Plug 'jbyuki/venn.nvim'
```

Usage
-----

* `set virtualedit=all` or `set ve=all`. This will allow you to freely move the cursor in the buffer. (see `help virtualedit`).

* Enter in Visual Block mode using `<C-v>`. Select the region where the box should be.

* Invoke `:VBox`. This will draw a rectangle. In case, it has a width or a height of 1, it will draw a line.
