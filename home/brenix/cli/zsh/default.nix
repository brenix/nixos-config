{ pkgs, lib, persistence, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "viins";

    sessionVariables = {
      GREP_COLOR = "1;31";
      PAGER = "less -inMRF";
    };

    completionInit = ''
      autoload -Uz compinit && compinit
      autoload -Uz bashcompinit && bashcompinit
    '';

    history.path = "$HOME/.local/share/zsh/history";

    shellAliases = {
      ave = "aws-vault exec";
      cat = "bat --paging=never --style=plain --decorations=never";
      cd = "z";
      cdu = "cd-gitroot";
      cp = "cp -riv";
      define = "googler -n 2 define";
      grep = "grep --color=auto";
      gl = "git pull --prune --tags";
      l = "ls -lhv";
      la = "ls -lAvh";
      ls = "grc ls -v --color=always --group-directories-first";
      mkdir = "mkdir -vp";
      mv = "mv -iv";
      mc = "mullvad connect";
      md = "mullvad disconnect";
      ms = "mullvad status";
      q = "googler";
      rm = "rm -I";
      s = "doas systemctl";
      svim = "doas nvim";
      sw = "git switch";
      v = "nvim";
      virsh = "virsh -c qemu:///system";
      vm = "virsh start win11";
    };

    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "9d003fc02dbaa6db06e6b12e8c271398478e0b5d";
          sha256 = "0s4xj7yv75lpbcwl4s8rgsaa72b41vy6nhhc5ndl7lirb9nl61l7";
        };
      }
      {
        name = "cd-gitroot";
        src = pkgs.fetchFromGitHub {
          owner = "mollifier";
          repo = "cd-gitroot";
          rev = "66f6ba7549b9973eb57bfbc188e29d2f73bf31bb";
          sha256 = "00aj9z3fa6ghjpz7s9cdqpfy4vh1v19z284p4f7xj0z40vrlbdx4";
        };
      }
      {
        name = "zsh-aws-vault";
        src = pkgs.fetchFromGitHub {
          owner = "blimmer";
          repo = "zsh-aws-vault";
          rev = "f65973613cc80fbed3a649f4069c0febb08a7408";
          sha256 = "PaR4TFnN8j7QqxpgIYP58ZCmztNoYGzHiAsJUO6zeHg=";
        };
      }
      {
        name = "zsh-fzy";
        src = pkgs.fetchFromGitHub {
          owner = "aperezdc";
          repo = "zsh-fzy";
          rev = "519327d9990fbea50f71649e378e650f594bb39b";
          sha256 = "C5cflRJqi+T53izr2PBJsFW6X3CVgIlY+hGT3ODC9lI=";
        };
      }
    ];

    initExtraFirst = ''
      # -- OPTIONS
      setopt alwaystoend         # Move cursor to end of word if completed in-word
      setopt appendhistory       # allow multiple sessions to append to history
      setopt autocd              # if a command cant be executed, cd into the dir
      setopt autopushd           # make cd push the old dir onto the dir stack
      setopt bashrematch         # enable bash regex matching
      setopt clobber             # allow files to be clobbered
      setopt completeinword      # not just at the end
      setopt extendedglob        # allow reg-ex style matching
      setopt hashlistall         # hash command paths when completion is attempted
      setopt histexpiredupsfirst # ignore recording duplicate commands
      setopt histignorealldups   # ignore recording duplicate commands
      setopt histignorespace     # ignore recording commands prefixed with a space
      setopt incappendhistory    # write to history file immediately, not when shell exits
      setopt interactivecomments # enable comments on the command line
      setopt nobeep              # avoid beeping
      setopt noflowcontrol       # no c-s/c-q output freezing
      setopt nohup               # dont send SIGHUP to background processes when exiting
      setopt null_glob           # dont error when no matching patterns exist when globbing
      setopt promptsubst         # allow expansion in prompts
      setopt pushdignoredups     # dont push the same dir twice
      setopt unset               # dont error out when unset parameters are used
    '';

    initExtra = ''
      # -- KEYBINDINGS
      # zsh-fzy
      bindkey '\ec' fzy-cd-widget
      bindkey '^T'  fzy-file-widget
      bindkey '^R'  fzy-history-widget
      bindkey '^P'  fzy-proc-widget
      zstyle :fzy:file command rg --files

      # -- COMPLETION
      # Completion configuration
      zstyle ':completion::complete:*' gain-privileges 1
      zstyle ':completion:*' rehash true
      zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
      zstyle ":completion:*" completer _expand _complete _ignored _approximate
      zstyle ":completion:*" insert-unambiguous true
      zstyle ":completion:::*:default" menu no select
      zstyle ':completion::complete:*' use-cache 1
      zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
      # Disable pasted text highlighting
      zle_highlight+=(paste:none)
      # Quote pasted URLs
      autoload -U url-quote-magic
      zle -N self-insert url-quote-magic
      # Complete aws cli
      complete -C ${pkgs.awscli}/bin/aws_completer aws
      # -- PATHS
      path=(
        $HOME/.krew/bin
        $HOME/.local/bin
        $HOME/go/bin
        $path[@]
      )
      fpath=(
        $HOME/.local/share/zsh/site-functions
        $fpath[@]
      )
      # -- SOURCE ADDITIONAL FILES
      # Load grc
      source ${pkgs.grc}/etc/grc.zsh
      # Load asdf
      source ${pkgs.asdf-vm}/etc/profile.d/asdf-prepare.sh
      # Source local files
      for f in $HOME/.zsh.d/*.zsh $HOME/.zsh.local.d/*.zsh; do
        source $f
      done
      # -- MISC
      # Disable auto menu after sourcing plugins etc
      setopt noautomenu
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "kubectl" "ssh-agent" "zoxide" ];
      extraConfig = ''
        # Fix case insensitive completion bug from oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh/issues/10972#issuecomment-1146806099)
        export CASE_SENSITIVE=true
        identities=()
        for i in $HOME/.ssh/id_(*~*pub); do
          identities+=''${i##*/}
        done
        zstyle :omz:plugins:ssh-agent identities ''${identities[@]}
      '';

      custom = "$HOME/.oh-my-zsh";
    };

  };

  home.file = {
    ".oh-my-zsh/lib/vcs_info.zsh".text = ""; # Nullify this lib due to upstream bugs
    ".zsh.d".source = ./zsh.d;
    ".zsh.d".recursive = true;
  };

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix" = {
      directories = [
        ".local/share/zsh"
        ".local/share/zoxide"
        ".zsh.local.d"
      ];
    };
  };
}
