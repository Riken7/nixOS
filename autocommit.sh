#!/usr/bin/env bash
if sudo nixos-rebuild switch --flake .; then
  git status
  git add .
  git commit -m "autocommit: $(date)"
  git push
else
  echo "nixos-rebuild failed"
  exit 1
fi
