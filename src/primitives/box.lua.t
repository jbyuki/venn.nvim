##../venn
@implement+=
function M.draw_box_utf(style)
  @get_box_dimensions
  @get_lines_in_range

  @restore_visual_select
  @get_cursor_position
  @restore_normal

  @append_whitespace_if_outside
  if w == 1 then
    @connect_line_if_possible_vertical
    @draw_vertical_line
  elseif h == 1 then
    @connect_line_if_possible_horizontal
    @draw_horizontal_line
  else
    @draw_over_box_top
    @draw_over_box_bottom
    @draw_over_box_left_right
  end

  @restore_visual_selection
  @restore_cursor_position
end

@implement+=
function M.get_width(line, byte)
  if byte then
    local substring = line:sub(1, byte)
    return vim.fn.strdisplaywidth(substring)
  else
    return vim.fn.strdisplaywidth(line)
  end
end

@get_box_dimensions+=
-- line is 1 indexed, col is 0 indexed
local _,slnum,sbyte,vscol = unpack(vim.fn.getpos("'<"))
local _,elnum,ebyte,vecol = unpack(vim.fn.getpos("'>"))

@get_lines_in_range+=
local lines = vim.api.nvim_buf_get_lines(0, slnum-1, elnum, true)
local scol = M.get_width(lines[1], sbyte-1) + vscol
local ecol = M.get_width(lines[#lines], ebyte-1) + vecol

if scol > ecol then
  scol, ecol = ecol, scol
end

local w = ecol - scol + 1
local h = elnum - slnum + 1

M.log("box dimensions " .. vim.inspect({w, h}))

@restore_visual_select+=
M.log("restore visual select")
vim.api.nvim_command [[normal! gv]]

@restore_normal+=
M.log("restore normal")
vim.api.nvim_command [[normal! vv]]

@get_cursor_position+=
local  _,clnum,cbyte,vccol = unpack(vim.fn.getpos('.'))
local cline = vim.api.nvim_buf_get_lines(0, clnum-1, clnum, true)[1]
local ccol = M.get_width(cline, cbyte-1) + vccol

@append_whitespace_if_outside+=
M.log("append whitespaces")
for i=1,#lines do
  local len = M.get_width(lines[i])
  local diff = ecol - len + 1
  if diff > 0 then
    @append_whitespaces_at_eol
  end
end

@append_whitespaces_at_eol+=
local extend = ""
for _=1,diff do
  extend = extend .. " "
end
local eol = string.len(lines[i])
vim.api.nvim_buf_set_text(0, slnum-1+(i-1), eol, slnum-1+(i-1), eol, { extend })
lines[i] = lines[i] .. extend

@implement+=
function M.get_bytes(line, col)
  -- kinda slow, not sure how to
  -- make it faster.
  local len = vim.str_utfindex(line)
  for i=0,len do
    local idx = vim.str_byteindex(line, i)
    if vim.fn.strdisplaywidth(line:sub(1,idx)) >= col then
      return idx
    end
  end
  return string.len(line)
end

@draw_over_box_top+=
M.log("draw box top")
local topborder = ""
for i=scol,ecol do
  if i == scol then
    @draw_upper_left
  elseif i == ecol then
    @draw_upper_right
  else
    @draw_upper_edge
  end
end
local sbyte = M.get_bytes(lines[1], scol)
local ebyte = M.get_bytes(lines[1], ecol+1)
vim.api.nvim_buf_set_text(0, slnum-1, sbyte, slnum-1, ebyte, { topborder })

@draw_upper_left+=
topborder = topborder .. M.gen_utf({" ", style, " ", style})

@draw_upper_right+=
topborder = topborder .. M.gen_utf({" ", style, style, " " })

@draw_upper_edge+=
topborder = topborder .. M.gen_utf({" ", " ", style, style })

@draw_over_box_bottom+=
M.log("draw box bot")
local botborder = ""
for i=scol,ecol do
  if i == scol then
    @draw_lower_left
  elseif i == ecol then
    @draw_lower_right
  else
    @draw_lower_edge
  end
end

local sbyte = M.get_bytes(lines[#lines], scol)
local ebyte = M.get_bytes(lines[#lines], ecol+1)
vim.api.nvim_buf_set_text(0, elnum-1, sbyte, elnum-1, ebyte, { botborder })

@draw_lower_left+=
botborder = botborder .. M.gen_utf({style, " ", " ", style })

@draw_lower_right+=
botborder = botborder .. M.gen_utf({style, " ", style, " " })

@draw_lower_edge+=
botborder = botborder .. M.gen_utf({" ", " ", style, style })

@draw_over_box_left_right+=
M.log("draw box left right")
for i=slnum,elnum-2 do
  @draw_left_border
  @draw_right_border
end

@draw_left_border+=
local len = string.len(lines[i-slnum+2])
local sbyte = M.get_bytes(lines[i-slnum+2], scol)
local sbyte_end = M.get_bytes(lines[i-slnum+2], scol+1)
vim.api.nvim_buf_set_text(0, i, sbyte, i, sbyte_end, { M.gen_utf({style, style, " ", " " }) })
lines[i-slnum+2] = vim.api.nvim_buf_get_lines(0, i, i+1, true)[1]

@scratch+=

    col
  0 |1 |2 3
   a| b| c
  1 |2 |3 4
    lua

@draw_right_border+=
local ebyte = M.get_bytes(lines[i-slnum+2], ecol)
local ebyte_end = M.get_bytes(lines[i-slnum+2], ecol+1)
vim.api.nvim_buf_set_text(0, i, ebyte, i, ebyte_end, { M.gen_utf({style, style, " ", " " }) })

@script_variables+=
local arrow_chars_utf = {
  up = '▲', down = '▼', left = '◄', right = '►',
}

@draw_vertical_line+=
for i=slnum-1,elnum-1 do
  local sbyte = M.get_bytes(lines[i-slnum+2], scol)
  local sbyte_end = M.get_bytes(lines[i-slnum+2], scol+1)

  local c
  if i+1 == clnum then
    @determine_arrow_up_or_down
  elseif i == elnum-1 or i == slnum-1 then
    c = tail or M.gen_utf({style, style, " ", " " })
  else
    c = M.gen_utf({style, style, " ", " " })
  end
  vim.api.nvim_buf_set_text(0, i, sbyte, i, sbyte_end , { c })
end

@determine_arrow_up_or_down+=
if i == slnum-1 then
  c = head or arrow_chars_utf.up
else
  c = head or arrow_chars_utf.down
end

@draw_horizontal_line+=
local line = ''
for i=scol,ecol do
  local c
  if i == ccol then
    @determine_if_arrow_left_or_right
  elseif i == scol or i == ecol then
    c = tail or M.gen_utf({" ", " ", style, style })
  else
    c = M.gen_utf({" ", " ", style, style })
  end
  line = line .. c
end

local sbyte = M.get_bytes(lines[1], scol)
local ebyte = M.get_bytes(lines[1], ecol+1)
vim.api.nvim_buf_set_text(0, slnum-1, sbyte, slnum-1, ebyte, { line })

@determine_if_arrow_left_or_right+=
if i == scol then
  c = head or arrow_chars_utf.left
else
  c = head or arrow_chars_utf.right
end

@connect_line_if_possible_vertical+=
local tail, head
if clnum == elnum then
  local sbyte = M.get_bytes(lines[1], scol)
  local ebyte = M.get_bytes(lines[1], scol+1)

  local ptail = lines[1]:sub(sbyte+1, ebyte)

  local sbyte = M.get_bytes(lines[#lines], ecol)
  local ebyte = M.get_bytes(lines[#lines], ecol+1)

  local phead = lines[#lines]:sub(sbyte+1, ebyte)

  @connect_line_going_down
else
  local sbyte = M.get_bytes(lines[#lines], ecol)
  local ebyte = M.get_bytes(lines[#lines], ecol+1)

  local ptail = lines[#lines]:sub(sbyte+1, ebyte)

  local sbyte = M.get_bytes(lines[1], scol)
  local ebyte = M.get_bytes(lines[1], scol+1)

  local phead = lines[1]:sub(sbyte+1, ebyte)

  @connect_line_going_up
end

@connect_line_going_down+=
local ptail_opts = M.parse(ptail)
if ptail_opts then
  ptail_opts[2] = style
  tail = M.gen_utf(ptail_opts) or tail
end

@connect_line_going_up+=
local ptail_opts = M.parse(ptail)
if ptail_opts then
  ptail_opts[1] = style
  tail = M.gen_utf(ptail_opts) or tail
end

@connect_line_if_possible_horizontal+=
local tail, head
if ccol == ecol then
  local sbyte = M.get_bytes(lines[1], scol)
  local ebyte = M.get_bytes(lines[1], scol+1)

  local ptail = lines[1]:sub(sbyte+1, ebyte)

  local sbyte = M.get_bytes(lines[1], ecol)
  local ebyte = M.get_bytes(lines[1], ecol+1)

  local phead = lines[1]:sub(sbyte+1, ebyte)

  @connect_line_going_right
else
  local sbyte = M.get_bytes(lines[1], ecol)
  local ebyte = M.get_bytes(lines[1], ecol+1)

  local ptail = lines[#lines]:sub(sbyte+1, ebyte)

  local sbyte = M.get_bytes(lines[1], scol)
  local ebyte = M.get_bytes(lines[1], scol+1)

  local phead = lines[1]:sub(sbyte+1, ebyte)

  @connect_line_going_left
end

@connect_line_going_right+=
local ptail_opts = M.parse(ptail)
if ptail_opts then
  ptail_opts[4] = style
  tail = M.gen_utf(ptail_opts) or tail
end

@connect_line_going_left+=
local ptail_opts = M.parse(ptail)
if ptail_opts then
  ptail_opts[3] = style
  tail = M.gen_utf(ptail_opts) or tail
end

@connect_line_going_right+=
local phead_opts = M.parse(phead)
if phead_opts then
  phead_opts[3] = style
  head = M.gen_utf(phead_opts) or head
end

@connect_line_going_left+=
local phead_opts = M.parse(phead)
if phead_opts then
  phead_opts[4] = style
  head = M.gen_utf(phead_opts) or head
end

@connect_line_going_down+=
local phead_opts = M.parse(phead)
if phead_opts then
  phead_opts[1] = style
  head = M.gen_utf(phead_opts) or head
end

@connect_line_going_up+=
local phead_opts = M.parse(phead)
if phead_opts then
  phead_opts[2] = style
  head = M.gen_utf(phead_opts) or head
end

@restore_cursor_position+=
M.log("restore cursor position")

local line = vim.api.nvim_buf_get_lines(0, clnum-1, clnum, true)[1]
local sbyte = M.get_bytes(line, ccol)
vim.api.nvim_win_set_cursor(0, {clnum, sbyte})

@restore_visual_selection+=
M.log("restore visual selection")
local lines = vim.api.nvim_buf_get_lines(0, slnum-1, elnum, true)

local sbyte = M.get_bytes(lines[1], scol)
local ebyte = M.get_bytes(lines[#lines], ecol)

vim.api.nvim_win_set_cursor(0, { slnum, sbyte+1 })

local hori_mvt = ""
if w-1 > 0 then
  hori_mvt = (w-1) .. "l"
end

local vert_mvt = ""
if h-1 > 0 then
  vert_mvt = (h-1) .. "j"
end

vim.cmd([[exe "norm! \<C-V>]] .. hori_mvt .. vert_mvt .. [[\<esc>"]])