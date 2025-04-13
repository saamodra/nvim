return {
  'tomasky/bookmarks.nvim',
  event = "VimEnter",
  config = function()
    require('bookmarks').setup {
      -- sign_priority = 8,  --set bookmark sign priority to cover other sign
      save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
      keywords =  {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function()
        local bm = require "bookmarks"
        local map = require('utils.map').map

        map("n", "mm", bm.bookmark_toggle, "Bookmark Toggle")
        map("n", "mi", bm.bookmark_ann, "Bookmark Annotation")
        map("n", "mc", bm.bookmark_clean, "Bookmark Clean")
        map("n", "mn", bm.bookmark_next, "Bookmark Next")
        map("n", "mp", bm.bookmark_prev, "Bookmark Previous")
        map("n", "ml", bm.bookmark_list, "Bookmark List")
        map("n", "mx", bm.bookmark_clear_all, "Bookmark Clear All")
      end
    }
  end
}
