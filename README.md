# nvim-project-watch

A Neovim plugin that triggers reloads when static files in Templ project is updated

## Installation

Using `packer.nvim`:

```lua
use {
    'Bparsons0904/nvim-templ-static-reload',
    config = function()
        require('nvim-project-watch').setup()
    end
}
```

Using `lazy.nvim`:

```lua
return {
    'Bparsons0904/nvim-templ-static-reload',
    config = function()
        require('nvim-project-watch').setup()
    end
}
```

## Setup

Add a `templ-reload.lua` to the root of the project.

```lua

return {
watch_direcorty = "/static/",
update_file = "/cmd/main.go",
}

```
