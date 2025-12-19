---
name: Generate a Commit Message for Staged Files
interaction: inline
description: staged file commit messages
opts:
  is_slash_cmd: true
  alias: commit-message
  auto_submit: true
  placement: add
---

## user

You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
${commit.staged_diff}
```
