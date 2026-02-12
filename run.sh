#!/bin/bash

if [ -d ".agent" ]; then
    echo "O diretório .agent já existe."
    exit 1
fi

git init
git submodule add git@github.com:caffeine-js/agent-guide.git .agent
