#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

# 1. Argument validation
NEW_DIR=$1

if [ -z "$NEW_DIR" ]; then
    echo -e "${RED}${LOGO} Error: Please provide the project directory name.${NC}"
    echo -e "${TIP} Usage: ${CYAN}caffeine init <directory-name>${NC}"
    exit 1
fi

# 2. Check if directory already exists
if [ -d "$NEW_DIR" ]; then
    echo -e "${RED}${LOGO} Error: Directory '${CYAN}$NEW_DIR${NC}' already exists.${NC}"
    exit 1
fi

# Get the absolute directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 3. Environment Setup
"$SCRIPT_DIR/install-environment.sh"

# 5. Project Initialization
echo -e "${CYAN}${LOGO} Creating project in '${UNDERLINE}$NEW_DIR${NC}'...${NC}"
mkdir -p "$NEW_DIR"

# Copying resources from ./resources to the root of the new directory
cp -r "$SCRIPT_DIR/resources/." "$NEW_DIR/"

# Initializing git and adding .agent
cd "$NEW_DIR"
git init
echo -e "${CYAN}${LOGO} Adding agent-guide submodule...${NC}"
git submodule add git@github.com:caffeine-js/agent-guide.git .agent

# 6. Configuration and Installation
"$SCRIPT_DIR/install-dependencies.sh"

# 7. Finalization
echo -e "${GREEN}----------------------------------------------------${NC}"
echo -e "${GREEN}${LOGO} Project '${UNDERLINE}$NEW_DIR${NC}' successfully created!${NC}"
echo -e "${YELLOW}${LOGO} IMPORTANT: Please update the project name in your 'package.json'.${NC}"
echo -e "${TIP} Location: ${CYAN}$NEW_DIR/package.json${NC}"
echo -e "${GREEN}----------------------------------------------------${NC}"


