##../venn
@script_variables+=
local log_filename
if vim.g.venn_debug then
  @build_logfile_filepath
end

@implement+=
function M.log(str)
  if log_filename then
    @open_log_file
    if f then
      @append_log_line
      @close_log_file
    end
  end
end

@build_logfile_filepath+=
log_filename = vim.fn.stdpath("data") .. "/venn.log"

@open_log_file+=
local f = io.open(log_filename, "a")

@append_log_line+=
f:write(str .. "\n")

@close_log_file+=
f:close()
