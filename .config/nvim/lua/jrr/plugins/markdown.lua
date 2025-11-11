return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "telekasten" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[
        let g:mkdp_auto_start = 0
        let g:mkdp_auto_close = 1
        let g:mkdp_refresh_slow = 0
        let g:mkdp_command_for_global = 0
        let g:mkdp_open_to_the_world = 0
        let g:mkdp_open_ip = ''
        let g:mkdp_browser = ''
        let g:mkdp_echo_preview_url = 0
        let g:mkdp_browserfunc = ''
        let g:mkdp_theme = 'dark'
        let g:mkdp_filetypes = ['markdown', 'telekasten']
        let g:mkdp_page_title = '「${name}」'
        let g:mkdp_preview_options = {
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'disable_filename': 0
            \ }
      ]])
    end,
  },
  {
    "preservim/vim-markdown",
    ft = { "markdown", "telekasten" },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_conceal_code_blocks = 0
    end,
  },
}