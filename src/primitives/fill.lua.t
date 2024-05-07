##../venn
@implement+=
function M.fill_box()
  @get_box_dimensions
  @get_lines_in_range

  @append_whitespace_if_outside

  local fill_char = '█'
  for i=slnum-1,elnum-1 do
    local len = string.len(lines[i-slnum+2])

    local sbyte = M.get_bytes(lines[i-slnum+2], scol)
    local ebyte = M.get_bytes(lines[i-slnum+2], ecol+1)

    local line = ""
    for i=scol,ecol do
      line = line .. fill_char
    end

    @set_character_fill
  end
end

@set_character_fill+=
vim.api.nvim_buf_set_text(0, i, sbyte, i, ebyte, { line })