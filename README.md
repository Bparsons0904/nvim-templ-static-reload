# nvim-project-watch

A Neovim plugin that triggers reloads when static files in Templ project is updated

## Installation

Using `packer.nvim`:

```lua
use {
    'Bparsons0904/nvim-templ-static-reload',
    config = function()
        require('nvim-templ-static-reload').setup()
    end
}
```

Using `lazy.nvim`:

```lua
return {
    'Bparsons0904/nvim-templ-static-reload',
    config = function()
        require('nvim-templ-static-reload').setup()
    end
}
```

## Setup

Add a `templ-reload.lua` to the root of the project.

```lua

return {
    watch_direcorty = "/directory_to_watch/",
    update_file = "/file_to_write_to", -- Can be any Go file within the project
}

```
