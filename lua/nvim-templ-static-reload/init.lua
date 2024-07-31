local M = {}

local function file_exists(incoming)
	local file = io.open(incoming, "r")
	if file then
		file:close()
	end
	return file ~= nil
end

local function load_project_config()
	local project_config_file = ".templ-reload.lua"
	local cwd = vim.fn.getcwd()
	local config_path = cwd .. "/" .. project_config_file

	if file_exists(config_path) then
		local config = dofile(config_path)
		return config
	end

	return nil
end

local function is_trigger_file(file, trigger_files)
	local ext = file:match("^.+(%..+)$")
	if ext then
		ext = ext:sub(2) -- remove the leading dot
		for _, trigger in ipairs(trigger_files) do
			if ext == trigger then
				return true
			end
		end
	end
	return false
end

local function on_buffer_write()
	local config = load_project_config()

	if not config then
		return
	end

	local current_buffer = vim.fn.expand("%:p")

	if config.trigger_files == nil or #config.trigger_files == 0 then
		return
	end

	if is_trigger_file(current_buffer, config.trigger_files) then
		local update_file = config.update_file

		local buf = vim.fn.bufnr(update_file, true)

		if not vim.api.nvim_buf_is_loaded(buf) then
			vim.fn.bufload(buf)
		end

		local current_window = vim.api.nvim_get_current_win()

		vim.api.nvim_command("vsplit")
		local new_window = vim.api.nvim_get_current_win()
		vim.api.nvim_set_current_buf(buf)
		vim.api.nvim_command("write")
		vim.api.nvim_win_close(new_window, true)

		vim.api.nvim_set_current_win(current_window)
	end
end

function M.setup()
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*",
		callback = on_buffer_write,
	})
end

return M
