#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

# Ensure mise is in the PATH for the current script execution
export PATH="$HOME/.local/share/mise/bin:$PATH"

if ! command -v mise &> /dev/null; then
    echo -e "${RED}${LOGO} Mise not found.${NC}"
    echo -e "${TIP} Please install it first or run the init script."
    exit 1
fi

# Always activate mise for this shell session to enable tools
eval "$(mise activate bash)"

# 1. Runtime Configuration
echo -e "${CYAN}${LOGO} Using mise to configure Bun...${NC}"
mise use bun@latest

# 2. Linter/Formatter Migration
echo -e "${CYAN}${LOGO} Running Biome migration...${NC}"
# We use || true here to prevent the script from failing if there's nothing to migrate
biome migrate --write || echo -e "${YELLOW}${LOGO} Warning: 'biome migrate' failed or no files found to migrate.${NC}"

# 3. Dependency Installation
echo -e "${CYAN}${LOGO} Installing dependencies with Bun...${NC}"
# Using mise exec to ensure the local bun version is used
mise exec -- bun i

echo -e "${GREEN}${LOGO} Dependencies installed successfully!${NC}"
