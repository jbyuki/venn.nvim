##../venn
@implement+=
function M.draw_box_over(style)
  @get_box_dimensions
  @get_lines_in_range

  @restore_visual_select
  @get_cursor_position
  @restore_normal

  @append_whitespace_if_outside
  if w == 1 then
    @draw_vertical_line_over
  elseif h == 1 then
    @draw_horizontal_line_over
  else
    @draw_over_box_top_over
    @draw_over_box_bottom_over
    @draw_over_box_left_right_over
  end

  @restore_visual_selection
  -- @restore_cursor_position
end

@draw_over_box_top_over+=
local topborder = ""
for i=scol,ecol do
  @get_character_at_position_top
  if i == scol then
    @draw_upper_left_over
  elseif i == ecol then
    @draw_upper_right_over
  else
    @draw_upper_edge_over
  end
end
local sbyte = M.get_bytes(lines[1], scol)
local ebyte = M.get_bytes(lines[1], ecol+1)
vim.api.nvim_buf_set_text(0, slnum-1, sbyte, slnum-1, ebyte, { topborder })

@get_character_at_position_top+=
local sbyte = M.get_bytes(lines[1], i)
local ebyte = M.get_bytes(lines[1], i+1)

local pold = lines[1]:sub(sbyte+1, ebyte)

@draw_upper_left_over+=
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[2] = style
pold_opts[4] = style
local old = M.gen(pold_opts) or M.gen({" ", style, " ", style})
topborder = topborder .. old

@draw_upper_right_over+=
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[2] = style
pold_opts[3] = style
local old = M.gen(pold_opts) or M.gen({" ", style, style, " "})
topborder = topborder .. old

@draw_upper_edge_over+=
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[3] = style
pold_opts[4] = style
local old = M.gen(pold_opts) or M.gen({" ", " ", style, style})
topborder = topborder .. old


@draw_over_box_bottom_over+=
local botborder = ""
for i=scol,ecol do
  @get_character_at_position_bot
  if i == scol then
    @draw_lower_left_over
  elseif i == ecol then
    @draw_lower_right_over
  else
    @draw_lower_edge_over
  end
end

local sbyte = M.get_bytes(lines[#lines], scol)
local ebyte = M.get_bytes(lines[#lines], ecol+1)
vim.api.nvim_buf_set_text(0, elnum-1, sbyte, elnum-1, ebyte, { botborder })

@get_character_at_position_bot+=
local sbyte = M.get_bytes(lines[#lines], i)
local ebyte = M.get_bytes(lines[#lines], i+1)

local pold = lines[#lines]:sub(sbyte+1, ebyte)

@draw_lower_left_over+=
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[1] = style
pold_opts[4] = style
local old = M.gen(pold_opts) or M.gen({style, " ", " ", style})
botborder = botborder .. old

@draw_lower_right_over+=
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[1] = style
pold_opts[3] = style
local old = M.gen(pold_opts) or M.gen({style, " ", style, " "})
botborder = botborder .. old

@draw_lower_edge_over+=
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[3] = style
pold_opts[4] = style
local old = M.gen(pold_opts) or M.gen({" ", " ", style, style })
botborder = botborder .. old

@draw_over_box_left_right_over+=
for i=slnum,elnum-2 do
  @draw_left_border_over
  @draw_right_border_over
end

@draw_left_border_over+=
local len = string.len(lines[i-slnum+2])
local sbyte = M.get_bytes(lines[i-slnum+2], scol)
local sbyte_end = M.get_bytes(lines[i-slnum+2], scol+1)

local pold = lines[i-slnum+2]:sub(sbyte+1, sbyte_end)
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[1] = style
pold_opts[2] = style
local old = M.gen(pold_opts)
local old = old or M.gen({style, style, " ", " " })

vim.api.nvim_buf_set_text(0, i, sbyte, i, sbyte_end, { old })
lines[i-slnum+2] = vim.api.nvim_buf_get_lines(0, i, i+1, true)[1]

@draw_right_border_over+=
local ebyte = M.get_bytes(lines[i-slnum+2], ecol)
local ebyte_end = M.get_bytes(lines[i-slnum+2], ecol+1)

local pold = lines[i-slnum+2]:sub(ebyte+1, ebyte_end)
local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
pold_opts[1] = style
pold_opts[2] = style
local old = M.gen(pold_opts)
local old = old or M.gen({style, style, " ", " " })

vim.api.nvim_buf_set_text(0, i, ebyte, i, ebyte_end, { old })

@draw_vertical_line_over+=
for i=slnum-1,elnum-1 do
  local sbyte = M.get_bytes(lines[i-slnum+2], scol)
  local sbyte_end = M.get_bytes(lines[i-slnum+2], scol+1)

  local pold = lines[i-slnum+2]:sub(sbyte+1, sbyte_end)
  local pold_opts = M.parse(pold) or { " ", " ", " ", " " }

  local c
  if i+1 == clnum then
    @determine_arrow_up_or_down_over
  elseif i == elnum-1 or i == slnum-1 then
    pold_opts[1] = style
    pold_opts[2] = style
    c = M.gen({style, style, " ", " " })
  else
    pold_opts[1] = style
    pold_opts[2] = style
    c = M.gen({style, style, " ", " " })
  end

  c = M.gen(pold_opts) or c
  vim.api.nvim_buf_set_text(0, i, sbyte, i, sbyte_end , { c })
end

@determine_arrow_up_or_down_over+=
if i == slnum-1 then
  c = arrow_chars.up
  pold_opts[2] = style
else
  c = arrow_chars.down
  pold_opts[1] = style
end

@draw_horizontal_line_over+=
local line = ''
for i=scol,ecol do
  @get_character_at_position_top
  local pold_opts = M.parse(pold) or { " ", " ", " ", " " }

  local c 
  if i == ccol then
    @determine_if_arrow_left_or_right_over
  elseif i == scol or i == ecol then
    pold_opts[3] = style
    pold_opts[4] = style
    c = M.gen({" ", " ", style, style })
  else
    pold_opts[3] = style
    pold_opts[4] = style
    c = M.gen({" ", " ", style, style })
  end

  c = M.gen(pold_opts) or c

  line = line .. c
end

local sbyte = M.get_bytes(lines[1], scol)
local ebyte = M.get_bytes(lines[1], ecol+1)
vim.api.nvim_buf_set_text(0, slnum-1, sbyte, slnum-1, ebyte, { line })

@determine_if_arrow_left_or_right_over+=
if i == scol then
  c = arrow_chars.left
  pold_opts[4] = style
else
  c = arrow_chars.right
  pold_opts[3] = style
end
