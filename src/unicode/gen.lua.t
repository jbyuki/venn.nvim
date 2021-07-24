##../venn
@implement+=
function M.gen(opts)
  for c, opt in pairs(charset) do
    if opt[1] == opts[1] and opt[2] == opts[2] and opt[3] == opts[3] and opt[4] == opts[4] then
      return c
    end
  end
end
