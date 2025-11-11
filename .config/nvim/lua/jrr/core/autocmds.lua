-- Auto-reload files when changed outside of Neovim
local augroup = vim.api.nvim_create_augroup("AutoReload", { clear = true })

-- Trigger reload when Neovim gains focus or when entering a buffer
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup,
  callback = function()
    if vim.api.nvim_get_mode().mode ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Notify when a file has changed
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = augroup,
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
  end,
})

-- Markdown-specific settings
local markdown_augroup = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = markdown_augroup,
  pattern = { "markdown", "telekasten" },
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = ""
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})