local function command(key, cmd, desc, icon, mode)
  return {
    __type = "command",
    key = key,
    cmd = cmd,
    desc = desc,
    icon = icon,
    mode = mode or "n"
  }
end

local function group(prefix, name, icon, items)
  return {
    __type = "group",
    prefix = prefix,
    name = name,
    icon = icon,
    items = items
  }
end

local function flatten_commands(entries, current_prefix)
  local result = {}
  for _, entry in ipairs(entries) do
    if entry.__type == "command" then
      local full_key = current_prefix .. entry.key
      table.insert(result, {
        full_key,
        "<cmd>" .. entry.cmd .. "<CR>",
        desc = entry.desc,
        icon = entry.icon,
        mode = entry.mode or "n",
      })
    elseif entry.__type == "group" then
      local group_key = current_prefix .. entry.prefix
      table.insert(result, {
        group_key,
        group = entry.name,
        icon = entry.icon,
      })

      -- 🔁 Recursively flatten subitems
      local nested = flatten_commands(entry.items, group_key)
      vim.list_extend(result, nested)
    else
      error("Unknown entry type: " .. tostring(entry.__type))
    end
  end
  return result
end

local mappings = {
  group('a', 'AI (Copilot)', '', {
    command('o', 'CopilotChatOpen', 'Open Chat', ''),
    command('c', 'CopilotChatClose', 'Close Chat', ''),
    command('C', 'CopilotChatToggle', 'Toggle Chat', ''),
    command('s', 'CopilotChatStop', 'Stop Chat Output', ''),
    command('r', 'CopilotChatReset', 'Reset Chat', ''),
    command('p', 'CopilotChatPrompts', 'List Prompts', ''),
    command('m', 'CopilotChatModels', 'List Models', ''),
    command('a', 'CopilotChatAgents', 'List Agents', ''),
    command('e', 'CopilotChatExplain', 'Explain', '', 'v'),
    command('r', 'CopilotChatReview', 'Review', '', 'v'),
    command('f', 'CopilotChatFix', 'Fix', '', 'v'),
    command('o', 'CopilotChatOptimize', 'Optimize', '', 'v'),
    command('d', 'CopilotChatDocs', 'Docs', '', 'v'),
    command('t', 'CopilotChatTests', 'Tests', '', 'v'),
    command('c', 'CopilotChatCommit', 'Commit', '', 'v'),
  }),
  group('b', 'Buffers', '󰱾', {
    command('l', 'lua Snacks.picker.buffers()', 'List', '󰱾'),
    command('n', 'enew', 'New', '󰱾'),
    command('c', 'lua Snacks.bufdelete()', 'Close', '󰱾'),
    command('<Left>', 'bp', 'Previous', '󰱾'),
    command('<Right>', 'bn', 'Next', '󰱾')
  }),
  group('c', 'Code', '', {
    command('q', 'lua Snacks.picker.qflist()', 'Quickfix', ''),
    command('s', 'lua Snacks.picker.lsp_symbols()', 'LSP Symbols (Buffer)', ''),
    command('n', 'lua Snacks.picker.todo_comments()', 'Notes / Comments', ''),
    command('S', 'lua Snacks.picker.lsp_workspace_symbols()', 'LSP Symbols (Workspace)', ''),
    command('d', 'lua Snacks.picker.diagnostics_buffer()', 'Diagnostics (Buffer)', ''),
    command('D', 'lua Snacks.picker.diagnostics()', 'Diagnostics (Workspace)', ''),
    command('t', 'lua Snacks.picker.treesitter()', 'LSP Symbols (Treesitter)', ''),
    command('f', 'lua vim.lsp.buf.format()', 'Format', '󰚟'),
    command('i', 'Lspsaga hover_doc', 'Info', '󰊕'),
    command('r', 'Lspsaga rename', 'Rename', '󰑕'),
    command('a', 'Lspsaga code_action', 'Actions', ''),
    command('o', 'Lspsaga outline', 'Outline', '󰊕'),
    command('c', 'CodeCompanionChat Toggle', 'Copilot Chat', ''),
    command('A', 'CodeCompanionActions', 'Copilot Actions', ''),
    group('g', 'Go To...', '', {
      command('d', 'lua Snacks.picker.lsp_definitions()', 'Definition', '󰊕'),
      command('D', 'lua Snacks.picker.lsp_declarations()', 'Declaration', '󰊕'),
      command('r', 'lua Snacks.picker.lsp_references()', 'References', '󰊕'),
      command('i', 'lua Snacks.picker.lsp_implemetations()', 'Implementations', '󰊕'),
      command('t', 'lua Snacks.picker.lsp_type_definitions()', 'Type Definition', '󰊕')
    })
  }),
  group("d", "Debug", "", {
    command("b", 'lua require("dap").toggle_breakpoint()', "Toggle Breakpoint", ""),
    command("B", 'lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))', "Conditional Breakpoint",
      ""),
    command("c", 'lua require("dap").continue()', "Continue", ""),
    command("C", 'lua require("dap").run_to_cursor()', "Run to Cursor", "󰜎"),
    command("g", 'lua require("dap").goto_()', "Go to Line", ""),
    command("o", 'lua require("dap").step_over()', "Step Over", ""),
    command("O", 'lua require("dap").step_out()', "Step Out", ""),
    command("i", 'lua require("dap").step_into()', "Step Into", ""),
    command("j", 'lua require("dap").down()', "Stack Down", ""),
    command("k", 'lua require("dap").up()', "Stack Up", ""),
    command("l", 'lua require("dap").run_last()', "Run Last", ""),
    command("p", 'lua require("dap").pause()', "Pause", ""),
    command("r", 'lua require("dap").repl.toggle()', "REPL", ""),
    command("R", 'lua require("dap").clear_breakpoints()', "Remove Breakpoints", ""),
    command("s", 'lua require("dap").session()', "Session Info", ""),
    command("t", 'lua require("dap").terminate()', "Terminate", "󰜃"),
    command("w", 'lua require("dap.ui.widgets").hover()', "Hover Widget", ""),
    command("u", 'lua require("dapui").toggle({})', "Toggle UI", ""),
    command("e", 'lua require("dapui").eval()', "Eval", ""),
  }),
  group('f', 'Files', '', {
    command('b', 'lua Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") })', 'Buffer', '󰱼'),
    command('w', 'lua Snacks.picker.files()', 'Workspace', ''),
    command('p', 'lua Snacks.picker.projects()', 'Projects', ''),
    command('r', 'lua Snacks.picker.recent()', 'Recents', ''),
    command('R', 'lua Snacks.rename.rename_file()', 'Rename', '󰑕'),
    command('e', 'lua Snacks.explorer()', 'Explorer', '󰀶'),
  }),
  group('g', 'Git', '', {
    command('b', 'lua Snacks.picker.git_branches()', 'Branches', ''),
    command('B', 'Gitsigns blame_line', 'Blame', ''),
    command('g', 'lua Snacks.picker.git_grep()', 'Grep', ''),
    command('l', 'lua Snacks.picker.git_log()', 'Log', ''),
    command('L', 'lua Snacks.picker.git_log_line()', 'Log Line', ''),
    command('s', 'lua Snacks.picker.git_status()', 'Status', ''),
    command('S', 'lua Snacks.picker.git_stash()', 'Stash', ''),
    command('d', 'lua Snacks.picker.git_diff()', 'Diff (Hunks)', ''),
    command('f', 'lua Snacks.picker.git_files()', 'Files', ''),
    command('F', 'lua Snacks.picker.git_log_file()', 'Log File', ''),
    group('h', 'GitHub', '', {
      command('a', 'Octo actions', 'Actions', ''),
      group('A', 'Assignee', '', {
        command('a', 'Octo assignee add', 'Add Assignee', ''),
        command('r', 'Octo assignee remove', 'Remove Assignee', ''),
      }),
      group('c', 'Projects (Cards)', '󰃢', {
        command('a', 'Octo card add', 'Add to project', '➕'),
        command('r', 'Octo card remove', 'Remove from project', '➖'),
        command('m', 'Octo card move', 'Move within project', '󰜺'),
      }),
      group('C', 'Comments', '', {
        command('a', 'Octo comment add', 'Add comment', ''),
        command('d', 'Octo comment delete', 'Delete comment', '󰆴'),
        command('s', 'Octo comment suggest', 'Suggest change', '󰦝'),
        command('u', 'Octo comment url', 'Open comment URL', ''),
      }),
      group('d', 'Discussions', '󰍩', {
        command('l', 'Octo discussion list', 'List discussions', '󰍩'),
        command('s', 'Octo discussion search', 'Search discussions', ''),
        command('c', 'Octo discussion create', 'New discussion', ''),
        command('x', 'Octo discussion close', 'Close discussion', ''),
        command('o', 'Octo discussion reopen', 'Reopen discussion', ''),
        command('r', 'Octo discussion reload', 'Reload discussion', ''),
        command('b', 'Octo discussion browser', 'Open in browser', ''),
        command('m', 'Octo discussion mark', 'Mark read', ''),
        command('u', 'Octo discussion unmark', 'Mark unread', '󰧭'),
      }),
      group('g', 'Gists', '', {
        command('l', 'Octo gist list', 'List gists', ''),
      }),
      group('i', 'Issues', '', {
        command('l', 'Octo issue list', 'List issues', ''),
        command('b', 'Octo issue browser', 'Open in browser', ''),
        command('u', 'Octo issue url', 'Copy issue URL', '󰅧'),
        command('r', 'Octo issue reload', 'Reload issue', ''),
        command('R', 'Octo issue reopen', 'Reopen issue', ''),
        command('x', 'Octo issue close', 'Close issue', ''),
        command('c', 'Octo issue create', 'Create issue', ''),
        command('p', 'Octo issue pin', 'Pin issue', ''),
        command('e', 'Octo issue edit', 'Edit issue', ''),
        command('U', 'Octo issue unpin', 'Unpin issue', ''),
        command('s', 'Octo issue search', 'Search issues', ''),
        command('d', 'Octo issue develop', 'Checkout branch', ''),
      }),
      group('l', 'Labels', '󰠠', {
        command('a', 'Octo label add', 'Add label', ''),
        command('n', 'Octo label create', 'Create label', ''),
        command('e', 'Octo label edit', 'Edit label', ''),
        command('x', 'Octo label delete', 'Delete label', ''),
        command('r', 'Octo label remove', 'Remove label', ''),
      }),
      group('m', 'Milestones', '󰃠', {
        command('l', 'Octo milestone list', 'List milestones', ''),
        command('a', 'Octo milestone add', 'Add milestone', ''),
        command('n', 'Octo milestone create', 'Create milestone', ''),
        command('r', 'Octo milestone remove', 'Remove milestone', ''),
      }),
      group('n', 'Notifications', '󰂚', {
        command('l', 'Octo notification list', 'List notifications', ''),
      }),
      group('P', 'Parent Issue', '󰷊', {
        command('a', 'Octo parent add', 'Add parent issue', ''),
        command('e', 'Octo parent edit', 'Edit parent link', '󰏫'),
        command('r', 'Octo parent remove', 'Remove parent', ''),
      }),
      group('p', 'Pull Requests', '', {
        command('l', 'Octo pr list', 'List pull requests', ''),
        command('b', 'Octo pr browser', 'Open in browser', ''),
        command('u', 'Octo pr url', 'Copy PR URL', '󰌷'),
        command('e', 'Octo pr edit', 'Edit PR', ''),
        command('c', 'Octo pr create', 'Create PR', ''),
        command('d', 'Octo pr diff', 'Show diff', ''),
        command('r', 'Octo pr runs', 'Show runs', ''),
        command('D', 'Octo pr draft', 'Mark as draft', '󰑖'),
        command('m', 'Octo pr merge', 'Merge PR', ''),
        command('R', 'Octo pr ready', 'Mark as ready', ''),
        command('x', 'Octo pr close', 'Close PR', '󰅙'),
        command('S', 'Octo pr reload', 'Reload PR', ''),
        command('s', 'Octo pr search', 'Search PRs', ''),
        command('o', 'Octo pr reopen', 'Reopen PR', '󰜉'),
        command('k', 'Octo pr checks', 'PR Checks', ''),
        command('C', 'Octo pr commits', 'Show commits', ''),
        command('h', 'Octo pr changes', 'Show changes', ''),
        command('t', 'Octo pr checkout', 'Checkout PR', ''),
      }),
      group('R', 'Reactions', '', {
        command('+', 'Octo reaction +1', '👍 Like', '👍'),
        command('-', 'Octo reaction -1', '👎 Dislike', '👎'),
        command('t', 'Octo reaction tada', '🎉 Tada', '🎉'),
        command('e', 'Octo reaction eyes', '👀 Eyes', '👀'),
        command('h', 'Octo reaction heart', '❤️ Heart', '❤️'),
        command('p', 'Octo reaction party', '🥳 Party', '🥳'),
        command('l', 'Octo reaction laugh', '😄 Laugh', '😄'),
        command('r', 'Octo reaction rocket', '🚀 Rocket', '🚀'),
        command('o', 'Octo reaction hooray', '🙌 Hooray', '🙌'),
        command('c', 'Octo reaction confused', '😕 Confused', '😕'),
        command('u', 'Octo reaction thumbs_up', '👍 Thumbs Up', '👍'),
        command('d', 'Octo reaction thumbs_down', '👎 Thumbs Down', '👎'),
      }),
      group('r', 'Repositories', '', {
        command('l', 'Octo repo list', 'List Repositories', '󰅍'),
        command('b', 'Octo repo browser', 'Open in Browser', ''),
        command('u', 'Octo repo url', 'Copy Repo URL', ''),
        command('f', 'Octo repo fork', 'Fork', ''),
        command('v', 'Octo repo view', 'View Details', '󰈈'),
        command('s', 'Octo repo search', 'Search', ''),
      }),
      group('v', 'Reviews', '', {
        command('s', 'Octo review start', 'Start Review', ''),
        command('c', 'Octo review commit', 'Commit Review', '󰇙'),
        command('t', 'Octo review thread', 'Reply to Thread', '󰓾'),
        command('u', 'Octo review submit', 'Submit Review', '󰱨'),
        command('b', 'Octo review browse', 'Open in Browser', ''),
        command('r', 'Octo review resume', 'Resume Review', '󰄲'),
        command('d', 'Octo review discard', 'Discard Review', ''),
        command('m', 'Octo review comments', 'Review Comments', '󰦨'),
        command('x', 'Octo review close', 'Close Review', ''),
      }),
      group('V', 'Reviewers', '', {
        command('a', 'Octo reviewer add', 'Add Reviewer', ''),
      }),
      group('w', 'Workflow', '󱙶', {
        command('l', 'Octo workflow list', 'List Workflows', ''),
        command('e', 'Octo workflow edit', 'Edit Workflow', ''),
      }),
      group('W', 'Workflow Runs', '', {
        command('l', 'Octo run list', 'List Workflow Runs', ''),
      }),
      group('t', 'Threads', '󰑀', {
        command('r', 'Octo thread resolve', 'Resolve Thread', ''),
        command('u', 'Octo thread unresolve', 'Unresolve Thread', ''),
      }),
      group('T', 'Types', '', {
        command('a', 'Octo type add', 'Add Type', ''),
        command('r', 'Octo type remove', 'Remove Type', ''),
      })
    })
  }),
  group('i', 'Interactive', '', {
    command('g', 'lua Snacks.lazygit()', 'Git', ''),
    command('d', 'lua CustomToggleLazyDocker()', 'Docker', ''),
    command('j', 'lua CustomToggleJira()', 'JIRA', ''),
    command('s', 'lua CustomToggleLazySQL()', 'SQL Client', ''),
    command('r', 'lua CustomToggleAtac()', 'REST Client', '󱂛'),
    command('t', 'ToggleTerm direction=float', 'Terminal', ''),
  }),
  group('l', 'Languages', '󰘦', {
    group('g', 'Golang', '󰟓', {
      command('i', 'GoInstallBinaries', 'Install All Tools', '󰣇'),
      command('u', 'GoUpdateBinaries', 'Update All Tools', '󰏗'),
      command('b', 'GoBuild', 'Go Build', '󰡱'),
      command('r', 'GoRun', 'Go Run', ''),
      command('s', 'GoStop', 'Go Stop Running Task', ''),
      command('c', 'GoCoverage -p', 'Coverage Current Package', ''),
      command('C', 'GoCoverage -R', 'Remove All Coverage', ''),
      command('f', 'GoFmt', 'Format File', ''),
      command('v', 'GoVet', 'Go Vet', ''),
      command('l', 'GoLint', 'Go Lint', '󰮼'),
      command('n', 'GoNew', 'Create Go File from Template', ''),
      command('g', 'GoGenReturn', 'Generate Return Values', ''),
      command('e', 'Govulnckeck', 'Run Vuln Check', '󰟛'),
      command('E', 'Goenum', 'Run Go Enum', ''),
      group("a", "Go ↔ Test", "", {
        command("a", "GoAlt!", "Open test/source file", ""),
        command("s", "GoAltS!", "Open test/source in split", ""),
        command("v", "GoAltV!", "Open test/source in vertical split", ""),
      }),
      group('t', 'Tests', '󰙨', {
        command('f', 'GoTestFunc', 'Test current function', '󰡱'),
        command('s', 'GoTestFunc -s', 'Select function to test', '󰺠'),
        command('F', 'GoTestFile', 'Test current file', '󰈙'),
        command('p', 'GoTestPkg', 'Test current package', ''),
        command('v', 'GoTestFunc -v', 'Verbose test (func)', ''),
        command('V', 'GoTestFile -v', 'Verbose test (file)', ''),
        command('a', 'GoAddTest', 'Add test for current function', ''),
        command('e', 'GoAddExpTest', 'Add tests for exported functions', '󰗀'),
        command('A', 'GoAddAllTest', 'Add tests for all functions', ''),
      }),
      group("d", "Debug", "", {
        command("d", "GoDebug", "Start Debug Session", ""),
        command("h", "GoDebug -h", "Show Help Info", "󰘥"),
        command("c", "GoDebug -c", "Compile Only", ""),
        command("t", "GoDebug -t", "Debug Test File", ""),
        command("R", "GoDebug -R", "Restart Debug Session", ""),
        command("n", "GoDebug -n", "Debug Nearest Test", ""),
        command("p", "GoDebug -p", "Debug Package Test", ""),
        command("e", "GoDebug -e program", "Exec DAP Program", ""),
        command("a", "GoDebug -a", "Attach Remote Process", ""),
        command("s", "GoDebug -s", "Stop Debug Session", ""),
        command("A", "GoDebug -A args", "Debug with Args", "󰳛"),
        command("k", "GoDbgKeys", "Show Debug Keymaps", ""),
        command("b", "GoBreakToggle", "Toggle Breakpoint", ""),
        command("B", "GoDbgStop", "Stop Debug (Alt)", ""),
        command("C", "GoDbgContinue", "Continue Debug", ""),
      }),
      group("M", "Mocks", "󰑤", {
        command("m", "GoMockGen", "Generate mock for current file", ""),
        command("s", "GoMockGen -s", "Generate mock (source mode)", ""),
        command("i", "GoMockGen -i", "Generate mock (interface mode)", "󰡱"),
        command("d", "GoMockGen -d", "Generate mock to ./mocks", ""),
      }),
      group("m", "Go Mod", "󰟓", {
        command("i", "GoModInit", "Initialize go.mod and restart LSP", "󰚲"),
        command("t", "GoModTidy", "Clean up dependencies and restart LSP", "󰧭"),
        command("v", "GoModVendor", "Create vendor dir and restart LSP", ""),
        command("w", "GoModWhy", "Explain why a dependency is needed", "󱓧"),
        command("d", "GoModDnld", "Download all module dependencies", ""),
        command("g", "GoModGraph", "Visualize module dependency graph", "󰲂"),
      }),
      group('x', 'Extras', '', {
        command('z', 'GoCheat', 'Go Cheat Sheet', ''),
        command('h', 'GoDoc', 'Show Go Doc', '󰋗'),
        command('H', 'GoDocBrowser', 'Go Doc in Browser', ''),
        command('P', 'GoPkgOutline -f', 'Outline Package', ''),
        command('I', 'GoImpl', 'Implement Interface', ''),
        command('M', 'Gomvp', 'Rename Module Name', '󱘖'),
        command('T', 'GoToggleInlay', 'Toggle Inlay Hints', ''),
      }),
      group('S', 'Structs', '', {
        command('a', 'GoAddTag json', 'Add JSON Tag', ''),
        command('r', 'GoRmTag json', 'Remove JSON Tag', ''),
        command('c', 'GoClearTag', 'Clear All Tags', ''),
        command('j', 'GoJson2Struct', 'JSON → Struct', ''),
      }),
    }),
    group('m', 'Markdown', '', {
      command('P', 'PeekOpen', 'Markdown Preview', ''),
      command('c', 'lua require("sc-im").open_in_scim()', 'Open in sc-im', ''),
      command('l', 'lua require("sc-im").open_in_scim(true)', 'Open with link', ''),
      command('p', 'lua require("sc-im").open_in_scim(false)', 'Open plain table', ''),
      command('t', 'lua require("sc-im").toggle(true)', 'Toggle link format', '󱇧'),
      command('r', 'lua require("sc-im").rename()', 'Rename linked file', '󰑕'),
      command('u', 'lua require("sc-im").update()', 'Update Markdown table', ''),
      command('U', 'lua require("sc-im").update(true)', 'Update sc + Markdown', '󱍸'),
    }),
    group('p', 'Python', '', {
      command('v', 'VenvSelect', 'Venv Selector', '')
    }),
    group('t', 'TypeScript', '', {
      command('o', 'TSToolsOrganizeImports', 'Organize + Remove Unused Imports', ''),
      command('s', 'TSToolsSortImports', 'Sort Imports Only', ''),
      command('u', 'TSToolsRemoveUnusedImports', 'Remove Unused Imports', '󰘚'),
      command('U', 'TSToolsRemoveUnused', 'Remove All Unused Statements', ''),
      command('a', 'TSToolsAddMissingImports', 'Add Missing Imports', ''),
      command('f', 'TSToolsFixAll', 'Fix All Errors', '󰁨'),
      command('d', 'TSToolsGoToSourceDefinition', 'Go to Source Definition', ''),
      command('r', 'TSToolsRenameFile', 'Rename Current File', ''),
      command('R', 'TSToolsFileReferences', 'Find File References', ''),
    })
  }),
  group("m", "Make", "", {
    command("o", "MFROpen", "Open Makefile", ""),
    command("e", "MFREdit", "Edit Makefile", ""),
    command("c", "MFRRun clean", "Clean project", "🧹"),
    command("k", "MFRRun check", "Run checks", "✅"),
    command("b", "MFRRun build", "Build project", "🛠️"),
    command("a", "MFRRun all", "Default target", ""),
    command("i", "MFRRun install", "Install deps", "📦"),
  }),
  group('s', 'Search', '', {
    command('t', 'lua Snacks.picker.grep()', 'Text (Workspace)', '󱎸'),
    command('T', 'lua Snacks.picker.grep_buffers()', 'Text (Buffer)', '󱎸'),
    command('w', 'lua Snacks.picker.grep_word()', 'Word', '󱎸'),
    command('r', 'lua Snacks.picker.registers()', 'Registers', ''),
    command('l', 'lua Snacks.picker.lines()', 'Lines', ''),
    command('c', 'nohl', 'Clear', ''),
    command('i', 'lua Snacks.picker.icons()', 'Icons', '󰥶'),
    command('h', 'lua Snacks.picker.search_history()', 'History', ''),
  }),
  group("t", "Test", "󰙨", {
    command("a", 'lua require("neotest").run.attach()', "Attach", ""),
    command("f", 'lua require("neotest").run.run(vim.fn.expand("%"))', "Run File", "󱎸"),
    command("A", 'lua require("neotest").run.run(vim.uv.cwd())', "Run All Files", "󰧞"),
    command("S", 'lua require("neotest").run.run({ suite = true })', "Run Suite", ""),
    command("n", 'lua require("neotest").run.run()', "Run Nearest", "󰛦"),
    command("l", 'lua require("neotest").run.run_last()', "Run Last", ""),
    command("s", 'lua require("neotest").summary.toggle()', "Toggle Summary", ""),
    command("o", 'lua require("neotest").output.open({ enter = true, auto_close = true })', "Open Output", ""),
    command("O", 'lua require("neotest").output_panel.toggle()', "Toggle Output Panel", ""),
    command("t", 'lua require("neotest").run.stop()', "Terminate", "󰓅"),
    command("d", 'lua require("neotest").run.run({ suite = false, strategy = "dap" })', "Debug Nearest", ""),
    command("D", 'lua require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })', "Debug File", ""),
    group("c", "Coverage", "", {
      command("t", "CoverageToggle", "Toggle Coverage", ""),
      command("s", "CoverageShow", "Show Coverage", "󰛨"),
      command("h", "CoverageHide", "Hide Coverage", "󰗠"),
      command("r", "CoverageLoad", "Reload", "󰚰"),
      command("c", "CoverageClear", "Clear Overlay", ""),
      command("S", "CoverageSummary", "Show Summary", ""),
    }),
  }),
  group('v', 'Vim', '', {
    command('h', 'lua Snacks.picker.help()', 'Help', '󰋖'),
    command('t', 'lua Snacks.picker.colorschemes()', 'Themes', '󰏘'),
    command('p', 'Lazy', 'Plugin Manager', '󱐥'),
    group('c', 'Commands', '', {
      command('a', 'lua Snacks.picker.autocmds()', 'Autocmd', '󱙺'),
      command('h', 'lua Snacks.notifier.command_history()', 'History', ''),
      command('s', 'lua Snacks.picker.commands()', 'Search', ''),
    }),
    group('C', 'Configuration', '', {
      command('e', 'e $MYVIMRC', 'Edit', ''),
      command('r', 'source $MYVIMRC', 'Reload', '󰑓'),
      command('f', 'lua Snacks.picker.files({ cwd = vim.fn.stdpath("config") })', 'Files', '󰱼')
    }),
    group('k', 'Keymaps', '', {
      command('e', 'e ~/.config/nvim/lua/plugins/keybindings.lua', 'Edit', ''),
      command('r', 'Lazy reload which-key.nvim', 'Reload', '󰑓'),
      command('s', 'lua Snacks.picker.keymaps()', 'Search', ''),
    }),
    group('l', 'LSP', '', {
      command('s', 'lua Snacks.picker.lsp_config()', 'Search', ''),
      command('m', 'Mason', 'Manager', ''),
    }),
    group('n', 'Notifications', '󱥁', {
      command('c', 'lua Snacks.notifier.hide()', 'Clear', ''),
      command('h', 'lua Snacks.notifier.show_history()', 'History', ''),
      command('s', 'lua Snacks.picker.notifications()', 'Search', ''),
    })
  }),
  command('z', 'lua Snacks.zen()', 'Zen Mode', '󰄄')
}

local which_key = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-mini/mini.icons',
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    preset = 'helix'
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
    wk.add(flatten_commands(mappings, "<leader>"))
  end
}

return { which_key }
