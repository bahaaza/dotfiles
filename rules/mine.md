---
applyTo: "**"
---

# Agent Guidelines

Always start by remembering the project context and any relevant information
from memory using serena and server-memory tools show "remembering" to the
user while doing it

## Before Starting

- Ask for clarification on missing requirements, schemas (input/output/
  elastic...), or data structures
- Confirm understanding before proceeding

## Planning

- Always switch serena to interactive planning mode before creating a pla
- Research each task before creating a plan
- Create a work plan; break into small tasks
- Use `sequentialthinking` tool for complex tasks
- Save approved plans to memory with status checkboxes

## Research

- Use `context7` for docs and best practices
- Use `serena` for code structure, symbols, and dependencies
- Use `fetch_webpage` for web info
- Cross-reference sources; flag unclear/conflicting docs

## Implementation

- Switch serena to interactive editing modes before editing code
- Follow language best practices; write clean, documented code
- Handle edge cases and errors
- Make incremental changes; explain each step before executing
- Present multiple approaches with pros/cons when applicable
- Start simple, iterate based on feedback

## Code Quality

- Run syntax checks after implementation
- Use language-specific linters (e.g., `eslint`, `pyright`, `ruff`, `luacheck`)
- Fix all errors; address warnings when reasonable
- Run formatters to ensure consistent style after implementation
- Validate configuration files (JSON, YAML, TOML)
- If a required CLI tool is missing, prompt the user to install it before proceeding

## Checkpoint

- `checkpoint-current.md` — Current session state (active task, progress, context)
- `task-{name}.md` — Current work plan with status checkboxes

## After Completing

- Update memory with new findings
- Mark completed tasks in memory (update `[ ]` to `[x]`)
- **Create completion checkpoint** with summary of changes
- Request feedback before next step

## Git

**What to commit to git (project knowledge):**

- Project overviews and codebase structure
- Code style conventions and patterns
- Architecture documentation (repositories, identity fields, relationships)
- Test infrastructure and how-to-run guides
- Suggested commands and tooling references
- Feature context and summaries (e.g. visualizer context)

**What NOT to commit to git (ephemeral/task-specific):**

- `task-plan*` — task plan files
- `plan-*` — planning files
- `checkpoint-*` — session checkpoints (current, history, rollback)
- `*-implementation*` — implementation tracking files

**Rule of thumb:** If a memory describes _what the project is_ or _how it
works_, commit it. If it describes _what you are doing right now_ or _what you
plan to do_, delete it when the task is done and never commit it.
