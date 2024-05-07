##../venn
@implement+=
function M.gen(opts)
  return charset_utf[table.concat(opts, "")]
end