-- Generated using ntangle.nvim
local log_filename
if vim.g.venn_debug then
  log_filename = vim.fn.stdpath("data") .. "/venn.log"

end

local arrow_chars = {
  up = '▲', down = '▼', left = '◄', right = '►',
}

local charset = {
  --      { up , down, left, right }
  --      s : single
  --      d : double
  --      b : bold
  [" "] = { " ", " " , " ", " " },
  ["│"] = { "s", "s" , " ", " " },
  ["┤"] = { "s", "s" , "s", " " },
  ["╡"] = { "s", "s" , "d", " " },
  ["╢"] = { "d", "d" , "s", " " },
  ["╖"] = { " ", "d" , "s", " " },
  ["╕"] = { " ", "s" , "d", " " },
  ["╣"] = { "d", "d" , "d", " " },
  ["║"] = { "d", "d" , " ", " " },
  ["╗"] = { " ", "d" , "d", " " },
  ["╝"] = { "d", " " , "d", " " },
  ["╜"] = { "d", " " , "s", " " },
  ["╛"] = { "s", " " , "d", " " },
  ["┐"] = { " ", "s" , "s", " " },
  ["└"] = { "s", " " , " ", "s" },
  ["┴"] = { "s", " " , "s", "s" },
  ["┬"] = { " ", "s" , "s", "s" },
  ["├"] = { "s", "s" , " ", "s" },
  ["─"] = { " ", " " , "s", "s" },
  ["┼"] = { "s", "s" , "s", "s" },
  ["╞"] = { "s", "s" , " ", "d" },
  ["╟"] = { "d", "d" , " ", "s" },
  ["╚"] = { "d", " " , " ", "d" },
  ["╔"] = { " ", "d" , " ", "d" },
  ["╩"] = { "d", " " , "d", "d" },
  ["╦"] = { " ", "d" , "d", "d" },
  ["╠"] = { "d", "d" , " ", "d" },
  ["═"] = { " ", " " , "d", "d" },
  ["╬"] = { "d", "d" , "d", "d" },
  ["╧"] = { "s", " " , "d", "d" },
  ["╨"] = { "d", " " , "s", "s" },
  ["╤"] = { " ", "s" , "d", "d" },
  ["╥"] = { " ", "d" , "s", "s" },
  ["╙"] = { "d", " " , " ", "s" },
  ["╘"] = { "s", " " , " ", "d" },
  ["╒"] = { " ", "s" , " ", "d" },
  ["╓"] = { " ", "d" , " ", "s" },
  ["╫"] = { "d", "d" , "s", "s" },
  ["╪"] = { "s", "s" , "d", "d" },
  ["┘"] = { "s", " " , "s", " " },
  ["┌"] = { " ", "s" , " ", "s" },
  ["┍"] = { " ", "s" , " ", "b" },
  ["┎"] = { " ", "b" , " ", "s" },
  ["┎"] = { " ", "b" , " ", "s" },
  ["┏"] = { " ", "b" , " ", "b" },
  ["┑"] = { " ", "s" , "b", " " },
  ["┒"] = { " ", "b" , "s", " " },
  ["┓"] = { " ", "b" , "b", " " },
  ["┕"] = { "s", " " , " ", "b" },
  ["┖"] = { "b", " " , " ", "s" },
  ["┗"] = { "b", " " , " ", "b" },
  ["┙"] = { "s", " " , "b", " " },
  ["┚"] = { "b", " " , "s", " " },
  ["┛"] = { "b", " " , "b", " " },
  ["┝"] = { "s", "s" , " ", "b" },
  ["┞"] = { "b", "s" , " ", "s" },
  ["┟"] = { "s", "b" , " ", "s" },
  ["┠"] = { "b", "b" , " ", "s" },
  ["┡"] = { "b", "s" , " ", "b" },
  ["┢"] = { "s", "b" , " ", "b" },
  ["┣"] = { "b", "b" , " ", "b" },
  ["┥"] = { "s", "s" , "b", " " },
  ["┦"] = { "b", "s" , "s", " " },
  ["┧"] = { "s", "b" , "s", " " },
  ["┨"] = { "b", "b" , "s", " " },
  ["┩"] = { "b", "s" , "b", " " },
  ["┪"] = { "s", "b" , "b", " " },
  ["┫"] = { "b", "b" , "b", " " },
  ["┭"] = { " ", "s" , "b", "s" },
  ["┮"] = { " ", "s" , "s", "b" },
  ["┯"] = { " ", "s" , "b", "b" },
  ["┰"] = { " ", "b" , "s", "s" },
  ["┱"] = { " ", "b" , "b", "s" },
  ["┲"] = { " ", "b" , "s", "b" },
  ["┳"] = { " ", "b" , "b", "b" },
  ["┵"] = { "s", " " , "b", "s" },
  ["┶"] = { "s", " " , "s", "b" },
  ["┷"] = { "s", " " , "b", "b" },
  ["┸"] = { "b", " " , "s", "s" },
  ["┹"] = { "b", " " , "b", "s" },
  ["┺"] = { "b", " " , "s", "b" },
  ["┻"] = { "b", " " , "b", "b" },
  ["┽"] = { "s", "s" , "b", "s" },
  ["┾"] = { "s", "s" , "s", "b" },
  ["┿"] = { "s", "s" , "b", "b" },
  ["╀"] = { "b", "s" , "s", "s" },
  ["╁"] = { "s", "b" , "s", "s" },
  ["╂"] = { "b", "b" , "s", "s" },
  ["╃"] = { "b", "s" , "b", "s" },
  ["╄"] = { "b", "s" , "s", "b" },
  ["╅"] = { "s", "b" , "b", "s" },
  ["╆"] = { "s", "b" , "s", "b" },
  ["╇"] = { "b", "s" , "b", "b" },
  ["╈"] = { "s", "b" , "b", "b" },
  ["╉"] = { "b", "b" , "b", "s" },
  ["╊"] = { "b", "b" , "s", "b" },
  ["╋"] = { "b", "b" , "b", "b" },
  ["┃"] = { "b", "b" , " ", " " },
  ["━"] = { " ", " " , "b", "b" },
  ["━"] = { " ", " " , "b", "b" },
}

local arrows = {
  ["▲"] = { " ", "s" , " ", " " },
  ["▼"] = { "s", " " , " ", " " },
  ["◄"] = { " ", " " , " ", "s" },
  ["►"] = { " ", " " , "s", " " },
}
local M = {}
function M.log(str)
  if log_filename then
    local f = io.open(log_filename, "a")

    if f then
      f:write(str .. "\n")

      f:close()
    end
  end
end

function M.draw_box(style)
  -- line is 1 indexed, col is 0 indexed 
  local _,slnum,sbyte,vscol = unpack(vim.fn.getpos("'<"))
  local _,elnum,ebyte,vecol = unpack(vim.fn.getpos("'>"))

  local lines = vim.api.nvim_buf_get_lines(0, slnum-1, elnum, true)
  local scol = M.get_width(lines[1], sbyte-1) + vscol
  local ecol = M.get_width(lines[#lines], ebyte-1) + vecol

  if scol > ecol then
    scol, ecol = ecol, scol
  end

  local w = ecol - scol + 1
  local h = elnum - slnum + 1

  M.log("box dimensions " .. vim.inspect({w, h}))


  M.log("restore visual select")
  vim.api.nvim_command [[normal! gv]]

  local  _,clnum,cbyte,vccol = unpack(vim.fn.getpos('.'))
  local ccol = M.get_width(lines[1], cbyte-1) + vccol

  M.log("restore normal")
  vim.api.nvim_command [[normal! vv]]


  M.log("append whitespaces")
  for i=1,#lines do
    local len = M.get_width(lines[i])
    local diff = ecol - len + 1
    if diff > 0 then
      local extend = ""
      for _=1,diff do
        extend = extend .. " "
      end
      local eol = string.len(lines[i])
      vim.api.nvim_buf_set_text(0, slnum-1+(i-1), eol, slnum-1+(i-1), eol, { extend })
      lines[i] = lines[i] .. extend

    end
  end

  if w == 1 then
    local tail, head
    if clnum == elnum then
      local sbyte = M.get_bytes(lines[1], scol)
      local ebyte = M.get_bytes(lines[1], scol+1)

      local ptail = lines[1]:sub(sbyte+1, ebyte)

      local sbyte = M.get_bytes(lines[#lines], ecol)
      local ebyte = M.get_bytes(lines[#lines], ecol+1)

      local phead = lines[#lines]:sub(sbyte+1, ebyte)

      local ptail_opts = M.parse(ptail)
      if ptail_opts then
        ptail_opts[2] = style
        tail = M.gen(ptail_opts) or tail
      end

      local phead_opts = M.parse(phead)
      if phead_opts then
        phead_opts[1] = style
        head = M.gen(phead_opts) or head
      end

    else
      local sbyte = M.get_bytes(lines[#lines], ecol)
      local ebyte = M.get_bytes(lines[#lines], ecol+1)

      local ptail = lines[#lines]:sub(sbyte+1, ebyte)

      local sbyte = M.get_bytes(lines[1], scol)
      local ebyte = M.get_bytes(lines[1], scol+1)

      local phead = lines[1]:sub(sbyte+1, ebyte)

      local ptail_opts = M.parse(ptail)
      if ptail_opts then
        ptail_opts[1] = style
        tail = M.gen(ptail_opts) or tail
      end

      local phead_opts = M.parse(phead)
      if phead_opts then
        phead_opts[2] = style
        head = M.gen(phead_opts) or head
      end

    end

    for i=slnum-1,elnum-1 do
      local sbyte = M.get_bytes(lines[i-slnum+2], scol)
      local sbyte_end = M.get_bytes(lines[i-slnum+2], scol+1)

      local c
      if i+1 == clnum then
        if i == slnum-1 then
          c = head or arrow_chars.up
        else
          c = head or arrow_chars.down
        end

      elseif i == elnum-1 or i == slnum-1 then
        c = tail or M.gen({style, style, " ", " " })
      else
        c = M.gen({style, style, " ", " " })
      end
      vim.api.nvim_buf_set_text(0, i, sbyte, i, sbyte_end , { c })
    end

  elseif h == 1 then
    local tail, head
    if ccol == ecol then
      local sbyte = M.get_bytes(lines[1], scol)
      local ebyte = M.get_bytes(lines[1], scol+1)

      local ptail = lines[1]:sub(sbyte+1, ebyte)

      local sbyte = M.get_bytes(lines[1], ecol)
      local ebyte = M.get_bytes(lines[1], ecol+1)

      local phead = lines[1]:sub(sbyte+1, ebyte)

      local ptail_opts = M.parse(ptail)
      if ptail_opts then
        ptail_opts[4] = style
        tail = M.gen(ptail_opts) or tail
      end

      local phead_opts = M.parse(phead)
      if phead_opts then
        phead_opts[3] = style
        head = M.gen(phead_opts) or head
      end

    else
      local sbyte = M.get_bytes(lines[1], ecol)
      local ebyte = M.get_bytes(lines[1], ecol+1)

      local ptail = lines[#lines]:sub(sbyte+1, ebyte)

      local sbyte = M.get_bytes(lines[1], scol)
      local ebyte = M.get_bytes(lines[1], scol+1)

      local phead = lines[1]:sub(sbyte+1, ebyte)

      local ptail_opts = M.parse(ptail)
      if ptail_opts then
        ptail_opts[3] = style
        tail = M.gen(ptail_opts) or tail
      end

      local phead_opts = M.parse(phead)
      if phead_opts then
        phead_opts[4] = style
        head = M.gen(phead_opts) or head
      end

    end

    local line = ''
    for i=scol,ecol do
      local c 
      if i == ccol then
        if i == scol then
          c = head or arrow_chars.left
        else
          c = head or arrow_chars.right
        end

      elseif i == scol or i == ecol then
        c = tail or M.gen({" ", " ", style, style })
      else
        c = M.gen({" ", " ", style, style })
      end
      line = line .. c
    end

    local sbyte = M.get_bytes(lines[1], scol)
    local ebyte = M.get_bytes(lines[1], ecol+1)
    vim.api.nvim_buf_set_text(0, slnum-1, sbyte, slnum-1, ebyte, { line })

  else
    M.log("draw box top")
    local topborder = ""
    for i=scol,ecol do
      if i == scol then
        topborder = topborder .. M.gen({" ", style, " ", style})

      elseif i == ecol then
        topborder = topborder .. M.gen({" ", style, style, " " })

      else
        topborder = topborder .. M.gen({" ", " ", style, style })

      end
    end
    local sbyte = M.get_bytes(lines[1], scol)
    local ebyte = M.get_bytes(lines[1], ecol+1)
    vim.api.nvim_buf_set_text(0, slnum-1, sbyte, slnum-1, ebyte, { topborder })

    M.log("draw box bot")
    local botborder = ""
    for i=scol,ecol do
      if i == scol then
        botborder = botborder .. M.gen({style, " ", " ", style })

      elseif i == ecol then
        botborder = botborder .. M.gen({style, " ", style, " " })

      else
        botborder = botborder .. M.gen({" ", " ", style, style })

      end
    end

    local sbyte = M.get_bytes(lines[#lines], scol)
    local ebyte = M.get_bytes(lines[#lines], ecol+1)
    vim.api.nvim_buf_set_text(0, elnum-1, sbyte, elnum-1, ebyte, { botborder })

    M.log("draw box left right")
    for i=slnum,elnum-2 do
      local len = string.len(lines[i-slnum+2])
      local sbyte = M.get_bytes(lines[i-slnum+2], scol)
      local sbyte_end = M.get_bytes(lines[i-slnum+2], scol+1)
      vim.api.nvim_buf_set_text(0, i, sbyte, i, sbyte_end, { M.gen({style, style, " ", " " }) })
      lines[i-slnum+2] = vim.api.nvim_buf_get_lines(0, i, i+1, true)[1]

      local ebyte = M.get_bytes(lines[i-slnum+2], ecol)
      local ebyte_end = M.get_bytes(lines[i-slnum+2], ecol+1)
      vim.api.nvim_buf_set_text(0, i, ebyte, i, ebyte_end, { M.gen({style, style, " ", " " }) })

    end

  end

  M.log("restore visual selection")
  local lines = vim.api.nvim_buf_get_lines(0, slnum-1, elnum, true)

  local sbyte = M.get_bytes(lines[1], scol)
  local ebyte = M.get_bytes(lines[#lines], ecol)

  vim.api.nvim_win_set_cursor(0, { slnum, sbyte+1 })

  -- local hori_mvt = ""
  -- if w-1 > 0 then
    -- hori_mvt = (w-1) .. "l"
  -- end

  -- local vert_mvt = ""
  -- if h-1 > 0 then
    -- vert_mvt = (h-1) .. "j"
  -- end

  -- local key = vim.api.nvim_replace_termcodes("<C-v>" .. hori_mvt .. vert_mvt .. "<esc>", true, false, true)
  -- vim.api.nvim_feedkeys(key, 'n', true)
  -- @restore_cursor_position
end

function M.get_width(line, byte)
  if byte then
    local substring = line:sub(1, byte)
    return vim.api.nvim_strwidth(substring)
  else
    return vim.api.nvim_strwidth(line)
  end
end

function M.get_bytes(line, col)
  -- kinda slow, not sure how to
  -- make it faster.
  local len = vim.str_utfindex(line)
  for i=0,len do
    local idx = vim.str_byteindex(line, i)
    if vim.api.nvim_strwidth(line:sub(1,idx)) >= col then
      return idx
    end
  end
  return string.len(line)
end

function M.draw_box_over(style)
  -- line is 1 indexed, col is 0 indexed 
  local _,slnum,sbyte,vscol = unpack(vim.fn.getpos("'<"))
  local _,elnum,ebyte,vecol = unpack(vim.fn.getpos("'>"))

  local lines = vim.api.nvim_buf_get_lines(0, slnum-1, elnum, true)
  local scol = M.get_width(lines[1], sbyte-1) + vscol
  local ecol = M.get_width(lines[#lines], ebyte-1) + vecol

  if scol > ecol then
    scol, ecol = ecol, scol
  end

  local w = ecol - scol + 1
  local h = elnum - slnum + 1

  M.log("box dimensions " .. vim.inspect({w, h}))


  M.log("restore visual select")
  vim.api.nvim_command [[normal! gv]]

  local  _,clnum,cbyte,vccol = unpack(vim.fn.getpos('.'))
  local ccol = M.get_width(lines[1], cbyte-1) + vccol

  M.log("restore normal")
  vim.api.nvim_command [[normal! vv]]


  M.log("append whitespaces")
  for i=1,#lines do
    local len = M.get_width(lines[i])
    local diff = ecol - len + 1
    if diff > 0 then
      local extend = ""
      for _=1,diff do
        extend = extend .. " "
      end
      local eol = string.len(lines[i])
      vim.api.nvim_buf_set_text(0, slnum-1+(i-1), eol, slnum-1+(i-1), eol, { extend })
      lines[i] = lines[i] .. extend

    end
  end

  if w == 1 then
    for i=slnum-1,elnum-1 do
      local sbyte = M.get_bytes(lines[i-slnum+2], scol)
      local sbyte_end = M.get_bytes(lines[i-slnum+2], scol+1)

      local pold = lines[i-slnum+2]:sub(sbyte+1, sbyte_end)
      local pold_opts = M.parse(pold) or { " ", " ", " ", " " }

      local c
      if i+1 == clnum then
        if i == slnum-1 then
          c = arrow_chars.up
          pold_opts[2] = style
        else
          c = arrow_chars.down
          pold_opts[1] = style
        end

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

  elseif h == 1 then
    local line = ''
    for i=scol,ecol do
      local sbyte = M.get_bytes(lines[1], i)
      local ebyte = M.get_bytes(lines[1], i+1)

      local pold = lines[1]:sub(sbyte+1, ebyte)

      local pold_opts = M.parse(pold) or { " ", " ", " ", " " }

      local c 
      if i == ccol then
        if i == scol then
          c = arrow_chars.left
          pold_opts[4] = style
        else
          c = arrow_chars.right
          pold_opts[3] = style
        end
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

  else
    local topborder = ""
    for i=scol,ecol do
      local sbyte = M.get_bytes(lines[1], i)
      local ebyte = M.get_bytes(lines[1], i+1)

      local pold = lines[1]:sub(sbyte+1, ebyte)

      if i == scol then
        local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
        pold_opts[2] = style
        pold_opts[4] = style
        local old = M.gen(pold_opts) or M.gen({" ", style, " ", style})
        topborder = topborder .. old

      elseif i == ecol then
        local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
        pold_opts[2] = style
        pold_opts[3] = style
        local old = M.gen(pold_opts) or M.gen({" ", style, style, " "})
        topborder = topborder .. old

      else
        local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
        pold_opts[3] = style
        pold_opts[4] = style
        local old = M.gen(pold_opts) or M.gen({" ", " ", style, style})
        topborder = topborder .. old


      end
    end
    local sbyte = M.get_bytes(lines[1], scol)
    local ebyte = M.get_bytes(lines[1], ecol+1)
    vim.api.nvim_buf_set_text(0, slnum-1, sbyte, slnum-1, ebyte, { topborder })

    local botborder = ""
    for i=scol,ecol do
      local sbyte = M.get_bytes(lines[#lines], i)
      local ebyte = M.get_bytes(lines[#lines], i+1)

      local pold = lines[#lines]:sub(sbyte+1, ebyte)

      if i == scol then
        local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
        pold_opts[1] = style
        pold_opts[4] = style
        local old = M.gen(pold_opts) or M.gen({style, " ", " ", style})
        botborder = botborder .. old

      elseif i == ecol then
        local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
        pold_opts[1] = style
        pold_opts[3] = style
        local old = M.gen(pold_opts) or M.gen({style, " ", style, " "})
        botborder = botborder .. old

      else
        local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
        pold_opts[3] = style
        pold_opts[4] = style
        local old = M.gen(pold_opts) or M.gen({" ", " ", style, style })
        botborder = botborder .. old

      end
    end

    local sbyte = M.get_bytes(lines[#lines], scol)
    local ebyte = M.get_bytes(lines[#lines], ecol+1)
    vim.api.nvim_buf_set_text(0, elnum-1, sbyte, elnum-1, ebyte, { botborder })

    for i=slnum,elnum-2 do
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

      local ebyte = M.get_bytes(lines[i-slnum+2], ecol)
      local ebyte_end = M.get_bytes(lines[i-slnum+2], ecol+1)

      local pold = lines[i-slnum+2]:sub(ebyte+1, ebyte_end)
      local pold_opts = M.parse(pold) or { " ", " ", " ", " " }
      pold_opts[1] = style
      pold_opts[2] = style
      local old = M.gen(pold_opts)
      local old = old or M.gen({style, style, " ", " " })

      vim.api.nvim_buf_set_text(0, i, ebyte, i, ebyte_end, { old })

    end

  end

  M.log("restore cursor position")
  -- local line = vim.api.nvim_buf_get_lines(0, clnum-1, clnum, true)[1] 
  -- local sbyte
  -- sbyte = M.get_bytes(line, ccol)
  -- vim.fn.setpos('.', { 0, clnum, sbyte+1, 0 })

end

function M.fill_box()
  -- line is 1 indexed, col is 0 indexed 
  local _,slnum,sbyte,vscol = unpack(vim.fn.getpos("'<"))
  local _,elnum,ebyte,vecol = unpack(vim.fn.getpos("'>"))

  local lines = vim.api.nvim_buf_get_lines(0, slnum-1, elnum, true)
  local scol = M.get_width(lines[1], sbyte-1) + vscol
  local ecol = M.get_width(lines[#lines], ebyte-1) + vecol

  if scol > ecol then
    scol, ecol = ecol, scol
  end

  local w = ecol - scol + 1
  local h = elnum - slnum + 1

  M.log("box dimensions " .. vim.inspect({w, h}))


  M.log("append whitespaces")
  for i=1,#lines do
    local len = M.get_width(lines[i])
    local diff = ecol - len + 1
    if diff > 0 then
      local extend = ""
      for _=1,diff do
        extend = extend .. " "
      end
      local eol = string.len(lines[i])
      vim.api.nvim_buf_set_text(0, slnum-1+(i-1), eol, slnum-1+(i-1), eol, { extend })
      lines[i] = lines[i] .. extend

    end
  end


  local fill_char = '█'
  for i=slnum-1,elnum-1 do
    local len = string.len(lines[i-slnum+2])

    local sbyte = M.get_bytes(lines[i-slnum+2], scol)
    local ebyte = M.get_bytes(lines[i-slnum+2], ecol+1)

    local line = ""
    for i=scol,ecol do
      line = line .. fill_char
    end

    vim.api.nvim_buf_set_text(0, i, sbyte, i, ebyte, { line })
  end
end

function M.gen(opts)
  for c, opt in pairs(charset) do
    if opt[1] == opts[1] and opt[2] == opts[2] and opt[3] == opts[3] and opt[4] == opts[4] then
      return c
    end
  end
end
function M.parse(sym)
  local opts = charset[sym] or arrows[sym]
  return vim.deepcopy(opts)
end

return M
