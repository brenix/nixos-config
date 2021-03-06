require("bufferline").setup({
  options = {
    offsets = { { filetype = "NvimTree", text = "Explorer" } },
    always_show_bufferline = true,
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 25,
    diagnostics = "nvim_diagnostic",
    enforce_regular_tabs = true,
    view = "multiwindow",
    show_buffer_close_icons = true,
    separator_style = "thin",
  },
  highlights = {
    -- Disable italic fonts
    buffer_selected = {
      gui = "bold",
    },
  },
})
