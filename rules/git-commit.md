---
applyTo: "**"
---

# Memory Management Rules for AI Agents

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
- `decisions*` — task-specific decision logs
- `task_completion_checklist*` — completion checklists
- `*-implementation*` — implementation tracking files
- `*-bug*` — bug investigation notes
- `*cleanup_plan*` — cleanup/refactor plans
- `context-cache*` — cached research findings

**Rule of thumb:** If a memory describes _what the project is_ or _how it
works_, commit it. If it describes _what you are doing right now_ or _what you
plan to do_, delete it when the task is done and never commit it.
