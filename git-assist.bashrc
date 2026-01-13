git-list() {
  echo "  Current list of commands in git-assist:"
  printf "\n"
  printf "   %-12s   %-12s   %-12s   %-12s\n" "init" "status" "add" "commit"
  printf "   %-12s   %-12s   %-12s   %-12s\n" "log" "diff" "branch" "switch"
  printf "   %-12s   %-12s   %-12s   %-12s\n" "checkout" "merge" "rebase" "fetch"
  printf "   %-12s   %-12s   %-12s   %-12s\n" "pull" "push" "stash" "reset"
  printf "   %-12s\n" "revert"
  printf "\n"
  echo "  To get details on the commands do: git-assist <optional-command>"
}


git-assist() {

  _ga_list() {
    echo "Use: git-assist <command>"
    echo
    printf "  %-12s %s\n" "COMMAND" "DESCRIPTION"
    printf "  %-12s %s\n" "-------" "-----------"
    printf "  %-12s %s\n" "init"     "Create a new Git repository in the current folder"
    printf "  %-12s %s\n" "status"   "Show what's changed, staged, and untracked"
    printf "  %-12s %s\n" "add"      "Stage file changes for the next commit"
    printf "  %-12s %s\n" "commit"   "Record staged changes as a commit"
    printf "  %-12s %s\n" "log"      "Show commit history"
    printf "  %-12s %s\n" "diff"     "Show file differences"
    printf "  %-12s %s\n" "branch"   "List/create/delete/rename branches"
    printf "  %-12s %s\n" "switch"   "Switch branches (modern)"
    printf "  %-12s %s\n" "checkout" "Switch branches or restore files (older)"
    printf "  %-12s %s\n" "merge"    "Merge another branch into the current branch"
    printf "  %-12s %s\n" "rebase"   "Reapply commits on top of another base commit"
    printf "  %-12s %s\n" "fetch"    "Download remote updates (no merge)"
    printf "  %-12s %s\n" "pull"     "Fetch + integrate updates"
    printf "  %-12s %s\n" "push"     "Upload commits to remote"
    printf "  %-12s %s\n" "stash"    "Temporarily save changes without committing"
    printf "  %-12s %s\n" "reset"    "Move HEAD / unstage / discard changes"
    printf "  %-12s %s\n" "revert"   "Undo a commit safely by creating a new commit"
    echo 
    printf "  %s\n" "Example:"
    printf "   %s\n" "git-assist add"
  }

  _ga_detail() {
    case "$1" in

      add)
        cat <<'EOF'
    Command:
        git add
    Purpose:
        Stages changes for the next commit.

    Usage:
        git add <file>
        git add .
        git add -A
        git add -p

    Common options:
        -A, --all        Stage all changes (new/modified/deleted)
        -u               Stage modified + deleted (NOT new files)
        -p, --patch      Interactive staging (pick hunks)
        -n, --dry-run    Show what would be staged
        -f, --force      Add ignored files (careful)

    Arguments:
        <file> / <path>  One or more files/folders to stage
EOF
        ;;

      commit)
        cat <<'EOF'
    Command:
        git commit
    Purpose:
      Creates a commit from STAGED changes.

    Usage:
        git commit -m "message"
        git commit -am "message"
        git commit --amend

    Common options:
        -m "msg"         Commit message
        -a               Auto-stage tracked modified/deleted files (not new files)
        --amend          Replace the last commit
        --no-edit        Keep existing commit message (with --amend)
EOF
        ;;

      status)
        cat <<'EOF'
    Command:
        git status
    Purpose:
        Shows the current state of your repo.

    Usage:
        git status
        git status -sb

    Common options:
        -s, --short      Compact output
        -b               Show branch info
EOF
        ;;

      push)
        cat <<'EOF'
    Command: 
        git push
    Purpose:
        Uploads your commits to the remote repo.

    Usage:
        git push
        git push -u origin main
        git push origin <branch>

    Common options:
        -u, --set-upstream       Link branch to remote tracking branch
        --force                  Force push (dangerous)
        --force-with-lease       Safer force push

    Arguments:
        <remote> <branch>        Example: origin main
EOF
        ;;

      pull)
        cat <<'EOF'
    Command: 
        git pull
    Purpose:
        Fetch + integrate remote updates into your current branch.

    Usage:
        git pull
        git pull origin main
        git pull --rebase

    Common options:
        --rebase         Rebase instead of merge
        --ff-only        Only fast-forward, otherwise fail
EOF
        ;;

      branch)
        cat <<'EOF'
    Command: 
        git branch
    Purpose:
        Manage branches.

    Usage:
        git branch
        git branch <name>
        git branch -d <name>
        git branch -D <name>

    Common options:
        -a               List all branches (local + remote)
        -r               List remote only
        -d               Delete branch (safe)
        -D               Force delete branch
        -m               Rename branch
EOF
        ;;

      log)
        cat <<'EOF'
    Command: 
        git log
    Purpose:
        Show commit history.

    Usage:
        git log
        git log --oneline --graph --decorate --all

    Common options:
        --oneline        Short one-line format
        --graph          Draw branch graph
        --decorate       Show branch/tag pointers
        -p               Show diffs per commit
        -n <num>         Limit commits
EOF
        ;;

      diff)
        cat <<'EOF'
    Command: 
        git diff
        Purpose:
        Compare changes.

    Usage:
        git diff               (unstaged changes)
        git diff --staged      (staged changes)
        git diff <A>..<B>      (between commits/branches)

    Common options:
        --staged, --cached     Show staged changes
        --stat                Summary view
EOF
        ;;
      init)
        cat <<'EOF'
    Command: 
        git init
    Purpose:
        Create a new Git repository in the current folder (creates the .git directory).

    Usage:
        git init
        git init <directory>

    Common options:
        -b <name>        Set the initial branch name (example: main)
EOF
        ;;

      switch)
        cat <<'EOF'
    Command: 
        git switch
    Purpose:
        Switch to another branch (modern replacement for branch switching in checkout).

    Usage:
        git switch <branch>
        git switch -c <new-branch>

    Common options:
        -c <name>        Create a new branch and switch to it
        -C <name>        Create/reset the branch and switch to it (overwrites if it exists)
EOF
        ;;

      checkout)
        cat <<'EOF'
    Command: 
        git checkout
    Purpose:
        Switch branches or restore files (older multi-purpose command).
        (Modern alternatives: git switch for branches, git restore for files)

    Usage:
        git checkout <branch>
        git checkout -b <new-branch>
        git checkout -- <file>

    Common options:
        -b <name>        Create a new branch and switch to it
        --               Separator used before file paths (prevents confusion with branch names)
EOF
        ;;

      merge)
        cat <<'EOF'
    Command: 
        git merge
    Purpose:
        Merge another branch into your current branch.

    Usage:
        git merge <branch>

    Common options:
        --no-ff          Always create a merge commit even if fast-forward is possible
        --ff-only        Only merge if fast-forward is possible, otherwise fail
        --abort          Cancel the merge if conflicts occurred
EOF
        ;;

      rebase)
        cat <<'EOF'
    Command: 
        git rebase
    Purpose:
        Reapply your commits on top of another branch/commit (rewrites history).

    Usage:
        git rebase <upstream>
        git rebase -i <upstream>

    Common options:
        -i               Interactive rebase (edit/squash/reorder commits)
        --continue       Continue after resolving conflicts
        --abort          Cancel rebase and return to the previous state
EOF
        ;;

      fetch)
        cat <<'EOF'
    Command: 
        git fetch
    Purpose:
        Download updates from a remote without merging them into your current branch.

    Usage:
        git fetch
        git fetch origin
        git fetch --all

    Common options:
        --all            Fetch from all remotes
        -p, --prune      Remove remote-tracking branches that no longer exist on the remote
EOF
        ;;

      stash)
        cat <<'EOF'
    Command: 
        git stash
    Purpose:
        Temporarily save uncommitted changes so you can work cleanly or switch branches.

    Usage:
        git stash
        git stash push -m "message"
        git stash pop
        git stash list

    Common options:
        push             Explicitly create a stash entry
        -m "msg"         Add a message to the stash
        -u               Include untracked files in the stash
        pop              Apply stash changes and remove that stash entry
        apply            Apply stash changes but keep the stash entry
EOF
        ;;

      reset)
        cat <<'EOF'
    Command: 
        git reset
    Purpose:
        Move HEAD / unstage files / optionally discard changes (can be destructive depending on mode).

    Usage:
        git reset <file>
        git reset --soft HEAD~1
        git reset --mixed HEAD~1
        git reset --hard HEAD~1

    Common options:
        --soft           Undo commit but keep changes staged
        --mixed          Undo commit and unstage changes (default)
        --hard           Undo commit and discard ALL changes (DANGEROUS)
EOF
        ;;

      revert)
        cat <<'EOF'
    Command: 
        git revert
    Purpose:
        Undo a commit safely by creating a new commit that reverses it (best for shared branches like main).

    Usage:
        git revert <commit>
        git revert HEAD~3..HEAD

    Common options:
        -n, --no-commit  Revert changes without auto-committing (lets you review/edit before committing)
EOF
        ;;


      *)
        return 1
        ;;
    esac
  }

  # ----------------- main behavior -----------------

  # If no argument: show list
  if [[ $# -eq 0 ]]; then
    _ga_list
    return 0
  fi

  # Basic aliases (optional)
  local q="$1"
  case "$q" in
    br) q="branch" ;;
    ci) q="commit" ;;
    st) q="status" ;;
    pl) q="pull" ;;
    ps) q="push" ;;
  esac

  # Show detailed help if it exists
  if _ga_detail "$q"; then
    return 0
  fi

  # Otherwise show error + list of available
  echo "No detailed help found for: $1"
  echo
  echo "Try one of these:"
  echo "  add, commit, status, push, pull, branch, log, diff"
  return 1
}
