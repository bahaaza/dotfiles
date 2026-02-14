# Agent Guidelines

## Before Starting

- Ask for clarification on missing requirements, schemas (input/output/
  elastic...), or data structures
- Check memory for related previous work
- Confirm understanding before proceeding

## Planning

- Research each task before creating a plan
- Create a work plan; break into small tasks
- Use `sequentialthinking` for complex tasks
- Save approved plans to memory with status checkboxes

## Research

- Use `context7` for docs and best practices
- Use `serena` for code structure, symbols, and dependencies
- Use `fetch_webpage` for web info
- Cross-reference sources; flag unclear/conflicting docs

## Implementation

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

## Checkpoint Memory

Maintain persistent state across sessions using checkpoint memory files.

### Checkpoint Files Structure

- `checkpoint-current.md` — Current session state (active task, progress, context)
- `checkpoint-history.md` — Log of all checkpoints with timestamps
- `checkpoint-rollback.md` — Saved states for potential rollback
- `task-plan.md` — Current work plan with status checkboxes
- `decisions.md` — Key decisions made and their rationale
- `context-cache.md` — Cached research findings and references

### When to Create Checkpoints

- **Before major changes**: Save state before refactoring, deleting, or restructuring
- **After completing tasks**: Checkpoint after each task in the plan
- **Before risky operations**: Save before running destructive commands
- **On user request**: Create checkpoint when asked to "save progress"
- **At natural breakpoints**: End of planning, research, implementation phases

### Checkpoint Format

```markdown
## Checkpoint: [YYYY-MM-DD HH:MM]

### Current State

- Task: [current task description]
- Phase: [planning|research|implementation|review]
- Progress: [X/Y tasks complete]

### Files Modified

- [list of files changed since last checkpoint]

### Context

- [relevant context, decisions, blockers]

### Rollback Instructions

- [steps to revert to this state if needed]
```

### Checkpoint Workflow

1. **Save checkpoint**: Use `write_memory` to save to `checkpoint-current.md`
2. **Archive to history**: Append checkpoint summary to `checkpoint-history.md`
3. **Update rollback**: Before overwriting, copy current to `checkpoint-rollback.md`
4. **Cross-reference**: Link to related memory files (`task-plan.md`, `decisions.md`)

### Rollback Process

1. Read `checkpoint-rollback.md` or specific entry from `checkpoint-history.md`
2. Restore state using saved context and file list
3. Use `git diff` or `get_changed_files` to identify changes since checkpoint
4. Revert files as needed; update `checkpoint-current.md` with restored state

### Memory Commands

- "save checkpoint" — Create immediate checkpoint
- "show checkpoints" — List from `checkpoint-history.md`
- "rollback to [checkpoint]" — Restore previous state
- "clear checkpoints" — Archive and reset checkpoint files

## After Completing

- Update memory with new findings
- Mark completed tasks in memory (update `[ ]` to `[x]`)
- **Create completion checkpoint** with summary of changes
- Request feedback before next step
