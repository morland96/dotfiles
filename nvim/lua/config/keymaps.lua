-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby
vim.keymap.del("n", "<leader>p", {})
local map = vim.keymap.set
local nx = { "n", "x" }

-- groups
local wk = require("which-key")
wk.add({
  { "<leader>p", group = "+project" },
  { "<leader>r", group = "+refactoring" },
})

map("n", "<Leader>wh", "<C-w>h", { desc = "Go to left window" })
map("n", "<Leader>wj", "<C-w>j", { desc = "Go to bottom window" })
map("n", "<Leader>wk", "<C-w>k", { desc = "Go to top window" })
map("n", "<Leader>wl", "<C-w>l", { desc = "Go to right window" })

if vim.g.vscode then
  -- Makes vscode happy
  map("n", "<Space>", "<Cmd>call VSCodeNotify('whichkey.show')<CR>", { silent = true })
  map("x", "<Space>", "<Cmd>call VSCodeNotify('whichkey.show')<CR>", { silent = true })

  -- Better Navigation
  map({ "n", "x" }, "<C-h>", "<Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>")
  map({ "n", "x" }, "<C-j>", "<Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>")
  map({ "n", "x" }, "<C-k>", "<Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>")
  map({ "n", "x" }, "<C-l>", "<Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>")
  -- Project
  map("n", "<Leader>pp", "<Cmd>call VSCodeNotify('workbench.action.files.openFolder')<CR>")
end

if vim.g.vscode then
else
  -- Windows Resize
  map("n", "<C-S-h>", "<C-w><", { desc = "Decrease window width" })
  map("n", "<C-S-j>", "<C-w>-", { desc = "Decrease window height" })
  map("n", "<C-S-k>", "<C-w>+", { desc = "Increase window height" })
  map("n", "<C-S-l>", "<C-w>>", { desc = "Increase window width" })

  -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
  map("n", "<A-h>", require("smart-splits").resize_left)
  map("n", "<A-j>", require("smart-splits").resize_down)
  map("n", "<A-k>", require("smart-splits").resize_up)
  map("n", "<A-l>", require("smart-splits").resize_right)
  -- moving between splits
  map("n", "<C-h>", require("smart-splits").move_cursor_left)
  map("n", "<C-j>", require("smart-splits").move_cursor_down)
  map("n", "<C-k>", require("smart-splits").move_cursor_up)
  map("n", "<C-l>", require("smart-splits").move_cursor_right)
  map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
  -- Kitty
  -- map(nx, "<C-h>", "<cmd>:KittyNavigateLef<cr>")
  -- map(nx, "<C-j>", "<cmd>:KittyNavigateDown<cr>")
  -- map(nx, "<C-k>", "<cmd>:KittyNavigateUp<cr>")
  -- map(nx, "<C-l>", "<cmd>:KittyNavigateRight<cr>")

  -- Git
  local neogit = require("neogit")

  map("n", "<Leader>gs", function()
    neogit.open({ kind = "floating", cwd = "%:p:h" })
  end, { desc = "Open Neogit" })

  map("n", "<Leader>gc", function()
    neogit.open({ "commit" })
  end, { desc = "Neogit commit" })

  -- fzf lua
  --  map("n", "<Leader>pp", "<Leader>fp", { desc = "Find Projects" })
  map("n", "<Leader>pf", LazyVim.pick("files"), { desc = "Find Project Files" })
  map("n", "<Leader>pg", LazyVim.pick("live_grep"), { desc = "Grep Project Files" })

  -- Telescope
  local telescope_builtin = require("telescope.builtin")

  -- Snack picker
  map("n", "<Leader>bb", Snacks.picker.buffers, { desc = "Find Buffers" })

  -- Editor
  map("n", "<D-k>", "<Cmd>m-2<CR>", { desc = "Move line up" })
  map("n", "<D-j>", "<Cmd>m+<CR>", { desc = "Move line down" })

  -- Files
  local format = function()
    require("lazyvim.plugins.lsp.format").format({ force = true })
  end

  map("n", "<Leader>fs", "<Cmd>write<CR>", { desc = "Save File" })
  map("n", "<D-s>", "<Cmd>write<CR>", { desc = "Save File" })

  map(nx, "<M-S-f>", format, { desc = "Format File" })

  -- Jump
  map("n", "<Leader>js", "<cmd>FzfLua treesitter<cr>", { desc = "Jump treesitter" })

  -- Search
  map("n", "<Leader>s.", "<cmd>FzfLua<cr>", { desc = "FzfLua search" })
  map("n", "<Leader>s/", "<cmd>Telescope<cr>", { desc = "Telescope search" })


  -- Goto
  map("n", "<Leader>ci", Snacks.picker.lsp_implementations, { desc = "Goto Implementation" })

  -- Bookmarks
  local bm = require("telescope").extensions.vim_bookmarks
  -- map(nx, "<Leader><enter>", bm.all, { desc = "List Bookmarks" })
  map(nx, "<Leader>mm", "<Cmd>BookmarkToggle<CR>", { desc = "Toggle Bookmark" })
  map(nx, "<Leader>mi", "<Cmd>BookmarkAnnotate<CR>", { desc = "Bookmark Annotate" })
  map(nx, "<Leader>mn", "<Cmd>BookmarkNext<CR>", { desc = "Next Bookmark" })
  map(nx, "<Leader>mp", "<Cmd>BookmarkPrev<CR>", { desc = "Previous Bookmark" })
  map(nx, "<Leader>ml", bm.all, { desc = "List Bookmarks" })
  map(nx, "<Leader>mc", "<Cmd>BookmarkClear<CR>", { desc = "Clear Bookmarks" })
  map(nx, "<Leader>mx", "<Cmd>BookmarkClearAll<CR>", { desc = "Clear All Bookmarks" })

  -- Refactor
  map("n", "<Leader>rr", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<Leader>ra", vim.lsp.buf.code_action, { desc = "Code Action" })
  map("n", "<Leader>g.", vim.lsp.buf.code_action, { desc = "Code Action" })

  -- Java: split jdtls's compiled-output folder away from Maven's target/classes.
  -- Rewrites the project's .classpath output paths to `bin` so jdtls's ECJ and
  -- `mvn compile` never write to the same directory (the autobuild race). Safe
  -- because this config has import.maven.enabled = false, so jdtls won't
  -- regenerate .classpath back to target/classes on import.
  -- Tracks which jdtls clients we've already made an autobuild decision for,
  -- so the check/notify runs once per server, not on every java buffer attach.
  local jdtls_autobuild_decided = {}

  -- True when the project's compiled output is separated from Maven's
  -- target/classes: .classpath exists and no output entry points at
  -- target/classes / target/test-classes (i.e. :JdtlsSplitOutput was applied).
  local function jdtls_output_is_split(root)
    local classpath = root and (root .. "/.classpath")
    if not classpath or vim.fn.filereadable(classpath) == 0 then
      return false
    end
    local content = table.concat(vim.fn.readfile(classpath), "\n")
    local shares = content:find('"target/classes"', 1, true) or content:find('"target/test-classes"', 1, true)
    return not shares
  end

  local function jdtls_split_output()
    local jdtls = vim.lsp.get_clients({ name = "jdtls" })[1]
    local root = jdtls and jdtls.config and jdtls.config.root_dir
    if not root then
      vim.notify("jdtls not attached / no project root", vim.log.levels.WARN)
      return
    end
    local classpath = root .. "/.classpath"
    if vim.fn.filereadable(classpath) == 0 then
      vim.notify(".classpath not found in " .. root, vim.log.levels.WARN)
      return
    end

    local content = table.concat(vim.fn.readfile(classpath), "\n")
    local new, n1 = content:gsub('"target/test%-classes"', '"bin"')
    local n2
    new, n2 = new:gsub('"target/classes"', '"bin"')
    if (n1 + n2) == 0 then
      vim.notify(".classpath already split (no target/classes output found)", vim.log.levels.INFO)
      return
    end

    vim.fn.writefile(vim.fn.readfile(classpath), classpath .. ".bak") -- backup original
    vim.fn.writefile(vim.split(new, "\n"), classpath)

    -- Ensure bin/ is git-ignored.
    local gitignore = root .. "/.gitignore"
    local ignored = false
    local lines = {}
    if vim.fn.filereadable(gitignore) == 1 then
      lines = vim.fn.readfile(gitignore)
      for _, l in ipairs(lines) do
        if l:match("^/?bin/?$") then
          ignored = true
          break
        end
      end
    end
    if not ignored then
      table.insert(lines, "bin/")
      vim.fn.writefile(lines, gitignore)
    end

    vim.notify(
      ("Split jdtls output -> bin (%d path(s) rewritten). Backup: .classpath.bak. Run :LspRestart to apply."):format(
        n1 + n2
      ),
      vim.log.levels.INFO
    )
  end
  vim.api.nvim_create_user_command("JdtlsSplitOutput", jdtls_split_output, {
    desc = "Point jdtls compiled output to bin/ (away from Maven target/classes)",
  })

  -- Java
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local wk = require("which-key")
      wk.add({
        { "<leader>clr", vim.lsp.codelens.refresh, desc = "Refresh CodeLens", buffer = args.buf },
        { "<leader>cla", vim.lsp.codelens.run, desc = "Run CodeLens", buffer = args.buf },
        { "<leader>cll", "<cmd>LspInfo<cr>", desc = "LSP Info", buffer = args.buf },
      })
      if client and client.name == "jdtls" then
        wk.add({
          { "<leader>ct", require("jdtls.tests").goto_subjects, desc = "Goto Subjects", buffer = args.buf },
          { "<leader>cI", require("jdtls").super_implementation, desc = "Goto Super", buffer = args.buf },
          {
            "<leader>cb",
            function()
              require("jdtls").compile("incremental")
            end,
            desc = "Compile (incremental)",
            buffer = args.buf,
          },
          {
            "<leader>cB",
            function()
              require("jdtls").compile("full")
            end,
            desc = "Compile (full)",
            buffer = args.buf,
          },
          {
            "<leader>cA",
            function()
              local jdtls = vim.lsp.get_clients({ name = "jdtls" })[1]
              if not jdtls then
                vim.notify("jdtls not attached", vim.log.levels.WARN)
                return
              end
              local settings = jdtls.settings or (jdtls.config and jdtls.config.settings) or {}
              local current = vim.tbl_get(settings, "java", "autobuild", "enabled")
              if current == nil then
                current = true
              end
              local next_state = not current
              settings = vim.tbl_deep_extend("force", settings, {
                java = { autobuild = { enabled = next_state } },
              })
              jdtls.settings = settings
              if vim.fn.has("nvim-0.11") == 1 then
                jdtls:notify("workspace/didChangeConfiguration", { settings = settings })
              else
                jdtls.notify("workspace/didChangeConfiguration", { settings = settings })
              end
              vim.notify("Java autobuild " .. (next_state and "ON" or "OFF"), vim.log.levels.INFO)
            end,
            desc = "Toggle Java autobuild",
            buffer = args.buf,
          },
        })

        -- Decide autobuild per project, once per client: enable it only if the
        -- compiled output is split from Maven's target/classes (no race). If not
        -- split, leave autobuild off and nudge the user to run :JdtlsSplitOutput.
        if not jdtls_autobuild_decided[client.id] then
          jdtls_autobuild_decided[client.id] = true
          local root = client.config and client.config.root_dir
          if jdtls_output_is_split(root) then
            local settings = client.settings or (client.config and client.config.settings) or {}
            settings = vim.tbl_deep_extend("force", settings, { java = { autobuild = { enabled = true } } })
            client.settings = settings
            if vim.fn.has("nvim-0.11") == 1 then
              client:notify("workspace/didChangeConfiguration", { settings = settings })
            else
              client.notify("workspace/didChangeConfiguration", { settings = settings })
            end
            vim.notify("jdtls: output split from Maven target/classes — autobuild ENABLED", vim.log.levels.INFO)
          else
            -- Maven (m2e) projects force output to target/classes and can't be
            -- redirected from the editor, so splitting isn't an option there —
            -- autobuild stays off (safe) and diagnostics refresh via <leader>cb.
            -- Only a non-Maven project with a shared .classpath benefits from
            -- :JdtlsSplitOutput.
            local is_maven = root and vim.fn.filereadable(root .. "/pom.xml") == 1
            if is_maven then
              vim.notify(
                "jdtls: Maven project — output is target/classes (shared with mvn). autobuild kept OFF; use <leader>cb to refresh diagnostics.",
                vim.log.levels.INFO
              )
            else
              vim.notify(
                "jdtls: output shares target/classes — autobuild OFF. Run :JdtlsSplitOutput then :LspRestart to enable live builds.",
                vim.log.levels.WARN
              )
            end
          end
        end
      end
    end,
  })
end
