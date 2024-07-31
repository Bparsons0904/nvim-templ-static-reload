# nvim-templ-static-reload

A Neovim plugin that triggers reloads when static files in Templ project is updated

This works as a replacement for forcing reloads detailed in the [templ.guide]("https://templ.guide/commands-and-tools/live-reload-with-other-tools")

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
    trigger_files = { "css", "js" },  -- List of file extensions to trigger actions
    update_file = "/cmd/main.go",      -- Can be any Go file within the project
}

```
