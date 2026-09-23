if status is-interactive
    # Init

    zoxide init fish | source
    oh-my-posh init fish --config ~/.config/oh-my-posh/fish.omp.json | source

    # Settings

    set -g fish_greeting ""
    set -gx EDITOR emacsclient -nw -a ""
    set -gx VISUAL emacsclient -c -a ""

    # Path

    fish_add_path /home/j0lms/.local/bin
    fish_add_path /home/j0lms/Descargas/jdt-language-server-1.9.0-202203031534/bin
    # Aliases

    alias fb="fzf --ansi --preview 'bat --color=always {}' --preview-window '~3' --preview-window=right:60%"
    alias fe="fzf --ansi --preview 'eza --color=always -la --no-user {}' --preview-window=right:60%"
    alias fk="ps -ef | fzf | awk '{print $2}' | xargs kill -9"
    alias la="eza -la"
    alias ..="cd .."
    alias ...="cd ../.."
    alias update="sudo apt update && sudo apt upgrade -y"
    alias hot="source ~/.config/fish/config.fish"
    alias emd="emacs --daemon"
    alias conf="$EDITOR ~/.config/fish/config.fish"
    alias fd="fdfind"
    alias fda="fd -t f . | fb"
    alias fdd="fd -t d . | fe"
    alias nali="sudo nala install -y"
    alias ta="tmux attach -t"
    alias td="tmux detach"
    alias tl="tmux list-sessions"
    alias ts="tmux new-session -s"
    alias tk="tmux kill-session -t"
    alias tks="tmux kill-server"
    alias tr="tmux source-file ~/.tmux.conf"
    alias ls="eza -al"
    alias ll='eza -lbF --git'
    alias llm='eza -lbGd --git --sort=modified'
    alias la='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale'
    alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale'
    alias lS='eza -1'
    alias lt='eza -a --tree --level=2'

    # Functions

    function frb --description "Buscar texto con ripgrep, previsualizar con bat y abrir con Emacs/Editor"
        rg --color=always --line-number --no-heading --smart-case "$argv" |
            fzf --ansi \
                --color "hl:-1:underline,hl+:-1:underline:reverse" \
                --delimiter : \
                --preview 'bat --color=always {1} --highlight-line {2}' \
                --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
                --bind "enter:become(emacsclient -nw -a '' +{2} {1})"
    end

    function frl --description "Búsqueda interactiva con ripgrep, fzf y $EDITOR (live-reload)"
        set -l rg_prefix "rg --column --line-number --no-heading --color=always --smart-case"
        fzf --ansi --disabled --query "$argv" \
            --bind "start:reload:$rg_prefix {q} || true" \
            --bind "change:reload:sleep 0.1; $rg_prefix {q} || true" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind "enter:become(emacsclient -nw -a '' +{2} {1})"
    end

    function fkp
        ps -ef | fzf --header-lines=1 \
            --layout=reverse \
            --preview 'ps -p {2} -o %cpu,%mem,cmd 2>/dev/null || echo "Process closed"' \
            --preview-window up:3:wrap \
            -m | awk '{print $2}' | xargs -r kill -15
    end

    function conf
        $EDITOR ~/.config/fish/config.fish
    end

    function acfg
        $EDITOR ~/.config/alacritty/alacritty.toml
    end

    function tcfg
        $EDITOR ~/.tmux.conf
    end

    function ecfg
        $EDITOR ~/.emacs.d/post-init.el
    end
end
