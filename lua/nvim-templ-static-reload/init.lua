local M = {}

local function file_exists(incoming)
	local file = io.open(incoming, "r")
	if file then
		file:close()
	end
	return file ~= nil
end

local function load_project_config()
	local project_config_file = ".temple-reload.lua"
	local cwd = vim.fn.getcwd()
	local config_path = cwd .. "/" .. project_config_file

	if file_exists(config_path) then
		local config = dofile(config_path)
		return config
	end

	return nil
end

local function is_subdirectory(parent, sub)
	local pattern = "^" .. parent:gsub("[-%%%[%]%.%+%?%^%$%(%)%*]", "%%%0") .. "/"
	return sub:find(pattern) ~= nil
end

local function on_buffer_write()
	local config = load_project_config()

	if not config then
		return
	end

	local current_buffer = vim.fn.expand("%:p")

	if is_subdirectory(config.watch_directory, current_buffer) then
		local update_file = config.update_file

		vim.cmd("edit " .. update_file)

		vim.cmd("write")
	end
end

function M.setup()
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*",
		callback = on_buffer_write,
	})
end

return M
