return {
  staged_diff = function() return vim.fn.system('git diff --staged') end,
}
