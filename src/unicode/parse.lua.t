##../venn
@implement+=
function M.parse(sym)
  for opt, c in pairs(charset) do
    if c == sym then
      return vim.split(opt, "")
    end
  end

  if sym == arrow_chars.up then
    return {" ", "s", " ", " "}
  elseif sym == arrow_chars.down then
    return {"s", " ", " ", " "}
  elseif sym == arrow_chars.left then
    return {" ", " ", " ", "s"}
  elseif sym == arrow_chars.right then
    return {" ", " ", "s", " "}
  end
end

@script_variables+=
local charset = {
  -- [ up down left right ] = char
  --      s : single
  --      d : double
  --      b : bold
  ["    "] = " ",
  ["ss  "] = "│",
  ["sss "] = "┤",
  ["ssd "] = "╡",
  ["dds "] = "╢",
  [" ds "] = "╖",
  [" sd "] = "╕",
  ["ddd "] = "╣",
  ["dd  "] = "║",
  [" dd "] = "╗",
  ["d d "] = "╝",
  ["d s "] = "╜",
  ["s d "] = "╛",
  [" ss "] = "┐",
  ["s  s"] = "└",
  ["s ss"] = "┴",
  [" sss"] = "┬",
  ["ss s"] = "├",
  ["  ss"] = "─",
  ["ssss"] = "┼",
  ["ss d"] = "╞",
  ["dd s"] = "╟",
  ["d  d"] = "╚",
  [" d d"] = "╔",
  ["d dd"] = "╩",
  [" ddd"] = "╦",
  ["dd d"] = "╠",
  ["  dd"] = "═",
  ["dddd"] = "╬",
  ["s dd"] = "╧",
  ["d ss"] = "╨",
  [" sdd"] = "╤",
  [" dss"] = "╥",
  ["d  s"] = "╙",
  ["s  d"] = "╘",
  [" s d"] = "╒",
  [" d s"] = "╓",
  ["ddss"] = "╫",
  ["ssdd"] = "╪",
  ["s s "] = "┘",
  [" s s"] = "┌",
  [" s b"] = "┍",
  [" b s"] = "┎",
  [" b s"] = "┎",
  [" b b"] = "┏",
  [" sb "] = "┑",
  [" bs "] = "┒",
  [" bb "] = "┓",
  ["s  b"] = "┕",
  ["b  s"] = "┖",
  ["b  b"] = "┗",
  ["s b "] = "┙",
  ["b s "] = "┚",
  ["b b "] = "┛",
  ["ss b"] = "┝",
  ["bs s"] = "┞",
  ["sb s"] = "┟",
  ["bb s"] = "┠",
  ["bs b"] = "┡",
  ["sb b"] = "┢",
  ["bb b"] = "┣",
  ["ssb "] = "┥",
  ["bss "] = "┦",
  ["sbs "] = "┧",
  ["bbs "] = "┨",
  ["bsb "] = "┩",
  ["sbb "] = "┪",
  ["bbb "] = "┫",
  [" sbs"] = "┭",
  [" ssb"] = "┮",
  [" sbb"] = "┯",
  [" bss"] = "┰",
  [" bbs"] = "┱",
  [" bsb"] = "┲",
  [" bbb"] = "┳",
  ["s bs"] = "┵",
  ["s sb"] = "┶",
  ["s bb"] = "┷",
  ["b ss"] = "┸",
  ["b bs"] = "┹",
  ["b sb"] = "┺",
  ["b bb"] = "┻",
  ["ssbs"] = "┽",
  ["sssb"] = "┾",
  ["ssbb"] = "┿",
  ["bsss"] = "╀",
  ["sbss"] = "╁",
  ["bbss"] = "╂",
  ["bsbs"] = "╃",
  ["bssb"] = "╄",
  ["sbbs"] = "╅",
  ["sbsb"] = "╆",
  ["bsbb"] = "╇",
  ["sbbb"] = "╈",
  ["bbbs"] = "╉",
  ["bbsb"] = "╊",
  ["bbbb"] = "╋",
  ["bb  "] = "┃",
  ["  bb"] = "━",
  ["  bb"] = "━",
}
