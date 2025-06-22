
# fmt lazy-lock.json
fmt-lock-json:
    bash ./sort-lock.sh


# some bash after install nvim
post-init:
    # build lua-json5 for nixos
    cd ~/.local/share/nvim/lazy/lua-json5 && ./install.sh
