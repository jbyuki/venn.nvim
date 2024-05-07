##../venn
@implement+=
function M.set_line(opts, new_char)
  charset_utf[table.concat(opts, "")] = new_char
end

function M.set_arrow(dir, new_char)
  if dir == "up" then
    arrow_chars_utf.up = new_char
  elseif dir == "down" then
    arrow_chars_utf.down = new_char
  elseif dir == "left" then
    arrow_chars_utf.left = new_char
  elseif dir == "right" then
    arrow_chars_utf.right = new_char
  else
    print(("venn.nvim: unknown dir for arrow %s!"):format(dir))
  end
end