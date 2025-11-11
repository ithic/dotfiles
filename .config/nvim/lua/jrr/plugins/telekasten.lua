return {
  "renerocksai/telekasten.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",
  },
  config = function()
    local home = vim.fn.expand("~/zettelkasten")
    
    require("telekasten").setup({
      home = home,
      take_over_my_home = true,
      auto_set_filetype = false,
      
      dailies = home .. "/" .. "daily",
      weeklies = home .. "/" .. "weekly",
      templates = home .. "/" .. "templates",
      
      extension = ".md",
      
      new_note_filename = "uuid",
      uuid_type = "%Y%m%d%H%M",
      uuid_sep = "-",
      
      follow_creates_nonexisting = true,
      dailies_create_nonexisting = true,
      weeklies_create_nonexisting = true,
      
      journal_auto_open = false,
      
      template_new_note = home .. "/" .. "templates/new_note.md",
      template_new_daily = home .. "/" .. "templates/daily.md",
      template_new_weekly = home .. "/" .. "templates/weekly.md",
      
      -- Enable template substitution
      template_handling = "smart",
      template_date_format = "%Y-%m-%d",
      
      image_subdir = "img",
      
      sort = "filename",
      
      plug_into_calendar = true,
      calendar_opts = {
        weeknm = 4,
        calendar_monday = 1,
        calendar_mark = "left-fit",
      },
      
      close_after_yanking = false,
      insert_after_inserting = true,
      
      tag_notation = "#tag",
      
      command_palette_theme = "dropdown",
      
      show_tags_theme = "dropdown",
      
      subdirs_in_links = true,
      
      template_handling = "smart",
      
      new_note_location = "smart",
      
      rename_update_links = true,
      
      follow_url_fallback = nil,
    })
    
    local tk = require("telekasten")
    
    vim.keymap.set("n", "<leader>zf", tk.find_notes, { desc = "Find notes" })
    vim.keymap.set("n", "<leader>zd", tk.find_daily_notes, { desc = "Find daily notes" })
    vim.keymap.set("n", "<leader>zg", tk.search_notes, { desc = "Search notes content" })
    vim.keymap.set("n", "<leader>zz", tk.follow_link, { desc = "Follow link" })
    vim.keymap.set("n", "<leader>zT", tk.goto_today, { desc = "Go to today's note" })
    vim.keymap.set("n", "<leader>zW", tk.goto_thisweek, { desc = "Go to this week's note" })
    vim.keymap.set("n", "<leader>zw", tk.find_weekly_notes, { desc = "Find weekly notes" })
    vim.keymap.set("n", "<leader>zn", tk.new_note, { desc = "Create new note" })
    vim.keymap.set("n", "<leader>zN", tk.new_templated_note, { desc = "Create new templated note" })
    vim.keymap.set("n", "<leader>zy", tk.yank_notelink, { desc = "Yank note link" })
    vim.keymap.set("n", "<leader>zc", "<cmd>CalendarT<CR>", { desc = "Show calendar" })
    vim.keymap.set("n", "<leader>zC", ":CalendarT<CR>", { desc = "Calendar (toggle)" })
    vim.keymap.set("n", "<leader>zi", tk.paste_img_and_link, { desc = "Paste image and link" })
    vim.keymap.set("n", "<leader>zt", function()
      -- Better todo toggle that cycles properly
      local line = vim.api.nvim_get_current_line()
      local new_line = line
      
      if line:match("^%s*%- %[x%]") then
        -- Completed -> Incomplete
        new_line = line:gsub("%- %[x%]", "- [ ]")
      elseif line:match("^%s*%- %[ %]") then
        -- Incomplete -> Completed
        new_line = line:gsub("%- %[ %]", "- [x]")
      elseif line:match("^%s*%- ") then
        -- List item without checkbox -> Add checkbox
        new_line = line:gsub("(%s*)%- ", "%1- [ ] ")
      elseif line:match("^%s*%*") or line:match("^%s*%d+%.") then
        -- Other list types -> Convert to checkbox
        new_line = line:gsub("^(%s*)%*", "%1-"):gsub("^(%s*)%d+%.", "%1-")
        new_line = new_line:gsub("(%s*)%- ", "%1- [ ] ")
      else
        -- No list item -> Create one
        new_line = vim.fn.substitute(line, "^\\(\\s*\\)", "\\1- [ ] ", "")
      end
      
      vim.api.nvim_set_current_line(new_line)
    end, { desc = "Toggle todo" })
    vim.keymap.set("n", "<leader>zb", tk.show_backlinks, { desc = "Show backlinks" })
    vim.keymap.set("n", "<leader>zF", function()
      -- Custom implementation to find linked notes
      local bufname = vim.api.nvim_buf_get_name(0)
      
      -- Check if we're in a zettelkasten note
      if not bufname:match("zettelkasten") or not bufname:match("%.md$") then
        vim.notify("This only works in Zettelkasten notes", vim.log.levels.WARN)
        return
      end
      
      local current_file = vim.fn.fnamemodify(bufname, ":t:r")
      if current_file == "" then
        vim.notify("Save the file first to find linked notes", vim.log.levels.WARN)
        return
      end
      
      require('telescope.builtin').live_grep({
        prompt_title = "Notes linking to: " .. current_file,
        cwd = vim.fn.expand("~/zettelkasten"),
        default_text = "\\[\\[" .. current_file .. "\\]\\]",
      })
    end, { desc = "Find notes linking here" })
    vim.keymap.set("n", "<leader>zI", tk.insert_img_link, { desc = "Insert image link" })
    vim.keymap.set("n", "<leader>zp", tk.preview_img, { desc = "Preview image" })
    vim.keymap.set("n", "<leader>zm", tk.browse_media, { desc = "Browse media" })
    vim.keymap.set("n", "<leader>za", tk.show_tags, { desc = "Show all tags" })
    vim.keymap.set("n", "<leader>#", tk.show_tags, { desc = "Show all tags" })
    vim.keymap.set("n", "<leader>zr", tk.rename_note, { desc = "Rename note" })
    
    vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>", { desc = "Insert link" })
    vim.keymap.set("i", "<C-l>", "<cmd>Telekasten insert_link<CR>", { desc = "Insert link (alt)" })
    
    -- Quick task search
    vim.keymap.set("n", "<leader>x", function()
      require('telescope.builtin').live_grep({
        prompt_title = "Tasks",
        cwd = vim.fn.expand("~/zettelkasten"),
        default_text = "- \\[ \\]",
        layout_config = { height = 0.4 },
      })
    end, { desc = "Quick task search" })
    
    vim.api.nvim_set_hl(0, "tkLink", { fg = "#689d6a", bg = "", underline = true })
    vim.api.nvim_set_hl(0, "tkBrackets", { fg = "#fabd2f", bg = "" })
    vim.api.nvim_set_hl(0, "tkHighlight", { bg = "#3c3836", fg = "#fb4934" })
    vim.api.nvim_set_hl(0, "tkTag", { fg = "#d3869b", bg = "", bold = true })
    
    -- Ensure markdown files in Zettelkasten get proper settings
    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
      pattern = "*.md",
      callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("zettelkasten") then
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = ""
        end
      end,
    })
  end,
}