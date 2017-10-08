#! /usr/bin/env bash
# installer script for git extras

echo
echo "Install git extras.."
echo

echo "Previous git extras (git prompt and git completion) are now included by
installing git via brew and will be sourced if installed; otherwise, they will
not be used."
echo

echo "Setting up git hooks..."
echo

echo "Removing hooks in .git/hooks..."
echo
[[ -e .git/hooks ]] && {
  [[ -L .git/hooks ]] && { rm -fv .git/hooks; }
  [[ -d .git/hooks ]] && { rm -fv .git/hooks/*; rmdir .git/hooks; }
}
echo "...done removing hooks"
echo

echo "Linking in hooks..."
echo
ln -Fivs ~/Dotfiles/hooks/ .git/
echo "...done linking in hooks"
echo

echo "...done with git hooks"
echo

echo "...done with git extras"
echo
