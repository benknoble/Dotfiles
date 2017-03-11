#! /bin/bash
# installer script for git extras

echo "INSTALL GIT EXTRAS"

read -n 1 -p "Install Git Completion Bash [Y/n]? " installGitCompletionBash && echo
if [[ $installGitCompletionBash =~ ^(y|Y) ]]; then
    echo "Installing Git Completion for Bash..."
    (curl -Lo# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash ~/.git-completion.bash) || echo "Git Completion for Bash installation failed"
else
    echo "Skipping Git Completion for Bash..."
fi

read -n 1 -p "Install Git Prompt [Y/n]? " installGitPrompt && echo
if [[ $installGitPrompt =~ ^(y|Y) ]]; then
    echo "Installing Git Prompt..."
    (curl -Lo# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh ~/.git-prompt.sh) || echo "Git Prompt installation failed"
else
    echo "Skipping Git Prompt..."
fi
