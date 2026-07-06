# =============================================================================
# Shared Environment Variables / PATH
# Sourced by both bash and zsh via their respective rc files.
# =============================================================================

# RISC-V toolchain
export PATH="$PATH:/home/honoka/work/riscv64/bin"

# Yarn / Node
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# User local bin
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Rust / Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# uv (Python package manager)
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
