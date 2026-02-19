#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

# 1. Runtime Management (Mise)
# Ensure mise is in the PATH for the current script execution
export PATH="$HOME/.local/share/mise/bin:$PATH"

if ! command -v mise &> /dev/null; then
    echo -e "${YELLOW}${LOGO} Mise not found. Installing...${NC}"
    curl https://mise.run | sh
fi

# Always activate mise for this shell session to enable tools
eval "$(mise activate bash)"

# 2. Linter Management (Biome/Brew)
if ! command -v biome &> /dev/null; then
    echo -e "${YELLOW}${LOGO} Biome not found. Trying to install via Homebrew...${NC}"
    
    if ! command -v brew &> /dev/null; then
        echo -e "${YELLOW}${LOGO} Homebrew not found. Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Adding brew to path for the current session (macOS Intel/Apple Silicon)
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
    
    brew install biome
fi

echo -e "${GREEN}${LOGO} Environment ready! (Mise, Homebrew, and Biome are installed)${NC}"
