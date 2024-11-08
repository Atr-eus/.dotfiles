return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ha", mark.add_file)
    vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)

    vim.keymap.set("n", "<leader>[", function()
      ui.nav_prev()
    end)
    vim.keymap.set("n", "<leader>]", function()
      ui.nav_next()
    end)
  end,
}
