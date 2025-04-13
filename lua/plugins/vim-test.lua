return {
  'vim-test/vim-test',
  config = function()
    vim.g["test#ruby#rspec#executable"] = "docker compose exec web bin/rspec"
  end,
}
