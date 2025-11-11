return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
      move_cursor = false,
    })

    -- Auto-format after surround operations
    local group = vim.api.nvim_create_augroup("SurroundFormat", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "nvim-surround-post",
      group = group,
      callback = function()
        -- Check if conform is available
        local ok, conform = pcall(require, "conform")
        if ok then
          -- Small delay to ensure the surround operation is complete
          vim.defer_fn(function()
            conform.format({
              lsp_fallback = true,
              async = false,
              timeout_ms = 1000,
            })
          end, 50)
        end
      end,
      desc = "Auto-format after surround operation",
    })
  end,
}
