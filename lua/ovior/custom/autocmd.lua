local M = {}


local function augroup(name)
  return vim.api.nvim_create_augroup("ovior_" .. name, { clear = true })
end

function M.setup()
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function()
      local exclude = { "gitcommit" }
      local buf = vim.api.nvim_get_current_buf()
      if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
        return
      end
      local mark = vim.api.nvim_buf_get_mark(buf, '"')
      local lcount = vim.api.nvim_buf_line_count(buf)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil_preview",
    callback = function(params)
      vim.keymap.set("n", "y", "o", { buffer = params.buf, remap = true, nowait = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "man",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "fugitive",
      "tsplayground",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })

  -- close buffer on q
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_buffer_with_q"),
    pattern = { "oil" },
    callback = function(event)
      vim.keymap.set("n", "q", function() require("mini.bufremove").delete(0, false) end,
        { buffer = event.buf, silent = true })
      -- vim.keymap.set("n", "<leader>s", "<nop>");
    end,
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup("restore_leader_s"),
    callback = function()
      local ft = vim.bo.filetype
      if ft ~= "oil" then
        vim.keymap.set("n", "<leader>s", ":w<CR>", { silent = true })
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      vim.keymap.set("n", "o", function()
        local line = vim.api.nvim_get_current_line()
        if line:match("^%s*%*") then
          return "o* "
        else
          return "o"
        end
      end, { buffer = true, expr = true })

      vim.keymap.set("n", "O", function()
        local line = vim.api.nvim_get_current_line()
        if line:match("^%s*%*") then
          return "O* "
        else
          return "O"
        end
      end, { buffer = true, expr = true })

      vim.keymap.set("i", "<CR>", function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]

        if line:match("^%s*%*") then
          return "<CR>* "
        elseif line:match("^%s*/%*%*") then
          return "<CR>* "
        else
          return "<CR>"
        end
      end, { buffer = true, expr = true })
    end
  })
end

return M
