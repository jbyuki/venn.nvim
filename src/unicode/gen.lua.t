##../venn
@implement+=
function M.gen(opts)
  return charset[table.concat(opts, "")]
end