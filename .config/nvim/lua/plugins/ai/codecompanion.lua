return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  init = function()
    require("plugins.ai.extensions.companion-notification").init()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "folke/noice.nvim",
    {
      "ravitemer/codecompanion-history.nvim",
      -- commit = "eb99d256352144cf3b6a1c45608ec25544a0813d"
    },
  },
  opts = {
    -- ignore_warnings = true,
    rules = {
      python = {
        description = "Memory files for Claude Code users",
        files = {
          "~/work/AI/rules/python_rules.md",
        },
        enabled = true,
      },
      mine = {
        description = "Memory files for Claude Code users",
        files = {
          "~/work/AI/rules/mine.md",
          "~/work/AI/rules/git-commit.md",
          "~/work/AI/rules/memory.md",
          "~/work/AI/rules/jira.md",
        },
        enabled = true,
      },
      opts = {
        chat = {
          autoload = { "default", "mine" },
        },
      },
    },
    display = {
      chat = {
        icons = {
          chat_fold = " ",
          chat_context = "📎️", -- You can also apply an icon to the fold
        },
        intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
        separator = "─", -- The separator between the different messages in the chat buffer
        show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
        show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        -- show_settings = true, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        show_tools_processing = true, -- Show the loading message when tools are being executed?
        start_in_insert_mode = false, -- Open the chat buffer in insert mode?
        auto_scroll = true, -- If you move your cursor while the LLM is streaming a response, auto-scrolling will be turned off.
        fold_context = false,
        fold_reasoning = false,
        show_reasoning = true,
      },
      -- diff = {
      --   provider = "mini_diff",
      -- },
    },
    interactions = {
      chat = {
        adapter = {
          name = "copilot",
          model = "claude-opus-4.6",
          -- model = "claude-sonnet-4",
          -- model = "gpt-5",
        },
        variables = {
          ["buffer"] = {
            opts = {
              -- Always sync the buffer by sharing its "diff"
              -- Or choose "all" to share the entire buffer
              default_params = "diff",
            },
          },
        },
        keymaps = {
          send = {
            modes = { n = "<C-s>", i = "<C-s>" },
            opts = {},
          },
          close = {
            modes = { n = "<C-c>", i = "<C-c>" },
            opts = {},
          },
        },
        slash_commands = {
          ["file"] = {
            -- Use Telescope as the provider for the /file command
            opts = {
              provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
            },
          },
        },
        tools = {
          ["cmd_runner"] = {
            opts = {
              allowed_in_yolo_mode = true,
            },
          },
          opts = {
            -- default_tools = { "my_dev_tools" },
            default_tools = { "full_stack_dev", "sequentialthinking", "context7", "knowledge_graph_memory", "serena", "fetch_webpage" },
            -- default_tools = { "full_stack_dev" },
          },
          groups = {
            ["my_dev_tools"] = {
              description = "A set of development tools for coding tasks",
              system_prompt = "I'm giving you access to the ${tools} to help you perform coding tasks. Use them wisely to assist the user effectively.",
              tools = {
                "next_edit_suggestion",
                "list_code_usages",
                "get_changed_files",
                -- "git__git_status",
                -- "git__git_diff_unstaged",
                -- "git__git_diff_staged",
                -- "git__git_diff",
                -- "git__git_commit",
                -- "git__git_add",
                -- "git__git_reset",
                -- "git__git_log",
                -- "git__git_create_branch",
                -- "git__git_checkout",
                -- "git__git_show",
                -- "git__git_branch",
                "serena__read_file",
                "serena__create_text_file",
                "serena__list_dir",
                "serena__find_file",
                "serena__replace_content",
                "serena__search_for_pattern",
                "serena__get_symbols_overview",
                "serena__find_symbol",
                "serena__find_referencing_symbols",
                "serena__replace_symbol_body",
                "serena__insert_after_symbol",
                "serena__insert_before_symbol",
                "serena__rename_symbol",
                "serena__write_memory",
                "serena__read_memory",
                "serena__list_memories",
                "serena__delete_memory",
                "serena__edit_memory",
                "serena__execute_shell_command",
                "serena__activate_project",
                "serena__get_current_config",
                "serena__check_onboarding_performed",
                "serena__onboarding",
                "serena__think_about_collected_information",
                "serena__think_about_task_adherence",
                "serena__think_about_whether_you_are_done",
                "serena__prepare_for_new_conversation",
                "sequentialthinking__sequentialthinking",
                "context7__resolve_library_id",
                "context7__query_docs",
              },
              opts = {
                collapse_tools = true, -- When true, show as a single group reference instead of individual tools
              },
            },
          },
        },
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true, -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
        },
      },
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer (default: gh)
          keymap = "gh",
          -- Keymap to save the current chat manually (when auto_save is disabled)
          save_chat_keymap = "sc",
          -- Save all chats by default (disable to save only manually using 'sc')
          auto_save = true,
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 7,
          -- Picker interface (auto resolved to a valid picker)
          picker = "default", --- ("telescope", "snacks", "fzf-lua", or "default")
          ---Optional filter function to control which chats are shown when browsing
          chat_filter = nil, -- function(chat_data) return boolean end
          -- Customize picker keymaps (optional)
          picker_keymaps = {
            rename = { n = "r", i = "<M-r>" },
            delete = { n = "d", i = "<M-d>" },
            duplicate = { n = "<C-y>", i = "<C-y>" },
          },
          ---Automatically generate titles for new chats
          auto_generate_title = true,
          title_generation_opts = {
            ---Adapter for generating titles (defaults to current chat adapter)
            adapter = nil, -- "copilot"
            ---Model for generating titles (defaults to current chat model)
            model = "gpt-4o", -- "gpt-4o"
            ---Number of user prompts after which to refresh the title (0 to disable)
            refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
            ---Maximum number of times to refresh the title (default: 3)
            max_refreshes = 3,
            format_title = function(original_title)
              -- this can be a custom function that applies some custom
              -- formatting to the title.
              return original_title
            end,
          },
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = false,
          ---When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
          ---Enable detailed logging for history extension
          enable_logging = false,

          -- Summary system
          summary = {
            -- Keymap to generate summary for current chat (default: "gcs")
            create_summary_keymap = "gCs",
            -- Keymap to browse summaries (default: "gbs")
            browse_summaries_keymap = "gbs",

            generation_opts = {
              adapter = nil, -- defaults to current chat adapter
              model = nil, -- defaults to current chat model
              context_size = 90000, -- max tokens that the model supports
              include_references = true, -- include slash command content
              include_tool_outputs = true, -- include tool execution results
              system_prompt = nil, -- custom system prompt (string or function)
              format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
            },
          },

          -- Memory system (requires VectorCode CLI)
          memory = {
            -- Automatically index summaries when they are generated
            auto_create_memories_on_summary_generation = true,
            -- Path to the VectorCode executable
            vectorcode_exe = "vectorcode",
            -- Tool configuration
            tool_opts = {
              -- Default number of memories to retrieve
              default_num = 10,
            },
            -- Enable notifications for indexing progress
            notify = true,
            -- Index all existing memories on startup
            -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
            index_on_startup = false,
          },
        },
      },
    },
    prompt_library = {
      markdown = {
        dirs = {
          "~/work/AI/prompts", -- Or absolute paths
        },
      },
      ["git cli commit"] = {
        interaction = "chat",
        description = "Generate a git commit message based on the git diff",
        opts = {
          -- index = 5,
          is_slash_cmd = true,
          auto_submit = true,
          alias = "git_commit",
        },
        prompts = {
          {
            role = "user",
            content = [[Generate a concise and descriptive git commit message based on the diff, use git cli diff to get the changes.]],
          },
        },
      },
    },
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat toggle<cr>", desc = "CodeCompanion Chat" },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion actions" },
  },
}
