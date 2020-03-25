export LC_ALL=C.utf8
export LANG=C.utf8

if [ -d "$HOME/.zshenv.d" ]; then
        for EXTENSION_FILE in $(find $HOME/.zshenv.d/ -name '*.zsh'); do
                source "$EXTENSION_FILE"
        done
fi
