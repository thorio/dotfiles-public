XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

export RUSTUP_HOME=${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}
export CARGO_HOME=${CARGO_HOME:-$XDG_DATA_HOME/cargo}
path+=("$CARGO_HOME/bin")
