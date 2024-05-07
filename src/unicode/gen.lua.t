##../venn
@implement+=
function M.gen_utf(opts)
  return charset_utf[table.concat(opts, "")]
end