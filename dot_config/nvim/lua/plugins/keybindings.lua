local which_key = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    preset = 'helix'
  },
  config = function(_, opts)
    local function command(key, cmd, desc, icon, mode)
      local prefix = '<cmd>'
      local suffix = '<CR>'
      mode = mode or 'n'
      return { key, prefix .. cmd .. suffix, desc = desc, icon = icon, mode = mode }
    end

    local function command_group(group, name, icon, keys)
      local keybindings = {}
      local prefix = '<leader>' .. group
      table.insert(keybindings, { prefix, group = name, icon = icon })
      for _, key in ipairs(keys) do
        table.insert(keybindings, { prefix .. key[1], key[2], desc = key.desc, icon = key.icon, mode = key.mode })
      end
      return keybindings
    end

    local wk = require('which-key')
    wk.setup(opts)
    wk.add(command_group('a', 'AI (Copilot)', '', {
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
      command('c', 'CopilotChatCommit', 'Commit', '', 'v')
    }))
    wk.add(command_group('b', 'Buffers', '󰱾', {
      command('l', 'lua Snacks.picker.buffers()', 'List', '󰱾'),
      command('n', 'enew', 'New', '󰱾'),
      command('d', 'lua Snacks.bufdelete()', 'Close', '󰱾'),
      command('<Left>', 'bp', 'Previous', '󰱾'),
      command('<Right>', 'bn', 'Next', '󰱾')
    }))
    wk.add(command_group('c', 'Code', '', {
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
    }))
    wk.add(command_group('cp', 'Plugins', '󱐥', {
      command('m', 'PeekOpen', 'Markdown Preview', ''),
      command('v', 'VenvSelect', 'Venv Selector', '')
    }))
    wk.add(command_group('cg', 'Go To...', '', {
      command('d', 'lua Snacks.picker.lsp_definitions()', 'Definition', '󰊕'),
      command('D', 'lua Snacks.picker.lsp_declarations()', 'Declaration', '󰊕'),
      command('r', 'lua Snacks.picker.lsp_references()', 'References', '󰊕'),
      command('i', 'lua Snacks.picker.lsp_implemetations()', 'Implementations', '󰊕'),
      command('t', 'lua Snacks.picker.lsp_type_definitions()', 'Type Definition', '󰊕')
    }))
    wk.add(command_group('f', 'Files', '', {
      command('b', 'lua Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") })', 'Buffer', '󰱼'),
      command('w', 'lua Snacks.picker.files()', 'Workspace', ''),
      command('p', 'lua Snacks.picker.projects()', 'Projects', ''),
      command('r', 'lua Snacks.picker.recent()', 'Recents', ''),
      command('R', 'lua Snacks.rename.rename_file()', 'Rename', '󰑕'),
      command('e', 'lua Snacks.explorer()', 'Explorer', '󰀶'),
    }))
    wk.add(command_group('g', 'Git', '', {
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
    }))
    wk.add(command_group('i', 'Interactive', '', {
      command('g', 'lua Snacks.lazygit()', 'Git', ''),
      command('d', 'lua CustomToggleLazyDocker()', 'Docker', ''),
      command('j', 'lua CustomToggleJira()', 'JIRA', ''),
      command('s', 'lua CustomToggleLazySQL()', 'SQL Client', ''),
      command('r', 'lua CustomToggleAtac()', 'REST Client', '󱂛'),
      command('t', 'ToggleTerm direction=float', 'Terminal', ''),
    }))
    wk.add(command_group('s', 'Search', '', {
      command('t', 'lua Snacks.picker.grep()', 'Text (Workspace)', '󱎸'),
      command('T', 'lua Snacks.picker.grep_buffers()', 'Text (Buffer)', '󱎸'),
      command('w', 'lua Snacks.picker.grep_word()', 'Word', '󱎸'),
      command('r', 'lua Snacks.picker.registers()', 'Registers', ''),
      command('l', 'lua Snacks.picker.lines()', 'Lines', ''),
      command('c', 'nohl', 'Clear', ''),
      command('i', 'lua Snacks.picker.icons()', 'Icons', '󰥶'),
      command('h', 'lua Snacks.picker.search_history()', 'History', ''),
    }))
    wk.add(command_group('v', 'Vim', '', {
      command('h', 'lua Snacks.picker.help()', 'Help', '󰋖'),
      command('t', 'lua Snacks.picker.colorschemes()', 'Themes', '󰏘'),
      command('p', 'Lazy', 'Plugin Manager', '󱐥'),
    }))
    wk.add(command_group('vc', 'Commands', '', {
      command('a', 'lua Snacks.picker.autocmds()', 'Autocmd', '󱙺'),
      command('h', 'lua Snacks.notifier.command_history()', 'History', ''),
      command('s', 'lua Snacks.picker.commands()', 'Search', ''),
    }))
    wk.add(command_group('vC', 'Configuration', '', {
      command('e', 'e $MYVIMRC', 'Edit', ''),
      command('r', 'source $MYVIMRC', 'Reload', '󰑓'),
      command('f', 'lua Snacks.picker.files({ cwd = vim.fn.stdpath("config") })', 'Files', '󰱼')
    }))
    wk.add(command_group('vk', 'Keymaps', '', {
      command('e', 'e ~/.config/nvim/lua/plugins/keybindings.lua', 'Edit', ''),
      command('r', 'Lazy reload which-key.nvim', 'Reload', '󰑓'),
      command('s', 'lua Snacks.picker.keymaps()', 'Search', ''),
    }))
    wk.add(command_group('vl', 'LSP', '', {
      command('s', 'lua Snacks.picker.lsp_config()', 'Search', ''),
      command('m', 'Mason', 'Manager', ''),
    }))
    wk.add(command_group('vn', 'Notifications', '󱥁', {
      command('c', 'lua Snacks.notifier.hide()', 'Clear', ''),
      command('h', 'lua Snacks.notifier.show_history()', 'History', ''),
      command('s', 'lua Snacks.picker.notifications()', 'Search', ''),
    }))
    wk.add(command('<leader>z', 'lua Snacks.zen()', 'Zen Mode', '󰄄'))
  end
}

return { which_key }
