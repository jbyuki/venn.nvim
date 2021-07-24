##../venn
@implement+=
function M.parse(sym)
  return vim.deepcopy(charset[sym])
end

@script_variables+=
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
}
