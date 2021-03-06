{ config, pkgs, lib, inputs, persistence, ... }:

let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) vimThemeFromScheme;

  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        inherit ref;
      };
    };
  # always installs latest version
  plugin = pluginGit "HEAD";

  # comment-box
  comment-box-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "comment-box-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "LudoPinelli";
      repo = "comment-box.nvim";
      rev = "117d55108edf3758da52cf1117584b974f5e76da";
      sha256 = "sha256-E+wQUtLJwqN42XYLu2OzAEKMMUyRKjcZHwgOOEG0XDM=";
    };
  };

  lsp-format-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lsp-format-nvim";
    dontBuild = true;
    src = pkgs.fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "lsp-format.nvim";
      rev = "a5a54eeb36d7001b4a6f0874dde6afd167319ac9";
      sha256 = "sha256-xFA+9JO3Rnj/CAYXb+oOnbslH3jgEapHA67I6dMFRFI=";
    };
  };
in
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = vimThemeFromScheme { scheme = config.colorscheme; };
        config = "colorscheme nix-${config.colorscheme.slug}";
      }
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      /* nvim-treesitter */
      Navigator-nvim
      better-escape-nvim
      bufferline-nvim
      /* circles-nvim */
      cmp-buffer
      cmp-emoji
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp-treesitter
      cmp_luasnip
      comment-box-nvim
      git-blame-nvim
      gitsigns-nvim
      gruvbox-material
      gruvbox-nvim
      lsp-format-nvim
      lsp_signature-nvim
      lspkind-nvim
      lualine-lsp-progress
      lualine-nvim
      luasnip
      mkdir-nvim
      nginx-vim
      nord-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-bufdel
      nvim-cmp
      nvim-colorizer-lua
      nvim-comment
      nvim-lspconfig
      nvim-tree-lua
      nvim-web-devicons
      project-nvim
      quickfix-reflector-vim
      stabilize-nvim
      switch-vim
      telescope-fzy-native-nvim
      telescope-nvim
      telescope-project-nvim
      todo-comments-nvim
      tokyonight-nvim
      trouble-nvim
      vim-better-whitespace
      vim-easy-align
      vim-terraform
      vim-terraform-completion
    ];

    extraPackages = with pkgs; [
      # plugin deps
      (python3.withPackages (ps: with ps; [ pynvim ueberzug ]))
      tree-sitter

      # language servers
      gopls
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.markdownlint-cli
      nodePackages.pyright
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      rnix-lsp
      sumneko-lua-language-server
      terraform-ls

      # formatters
      nixpkgs-fmt
      nodePackages.prettier
      python310Packages.mdformat
      shellharden
      shfmt
      stylua

      # diagnostics
      statix
    ];

    extraConfig = ''
      lua << EOF
        -- DISABLE BUILTINS
        local disabled_built_ins = {
          "2html_plugin",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
        }
        for _, plugin in pairs(disabled_built_ins) do
          vim.g["loaded_" .. plugin] = 1
        end

        -- MODULES
        local modules = {
          "core.utils",
          "core.options",
          "core.mappings",
          "plugins"
        }

        for _, module in ipairs(modules) do
          local ok, err = pcall(require, module)
          if not ok then
            error("Error loading " .. module .. "\n\n" .. err)
          end
        end

        -- COLORSCHEME
        vim.g.nord_contrast = false
        vim.g.nord_borders = true
        vim.g.nord_disable_background = true
        vim.g.nord_italic = true
        vim.g.nord_bold = false
        vim.g.gruvbox_material_background = "hard"
        vim.cmd[[colorscheme nix-${config.colorscheme.slug}]]
      EOF

      hi LineNr guifg=#${config.colorscheme.colors.base02}
      hi NvimTreeNormal guibg=#${config.colorscheme.colors.base00}
      "hi NvimTreeFolderIcon guifg=#${config.colorscheme.colors.base0A}
      hi NvimTreeFolderName guifg=#${config.colorscheme.colors.base05}
      hi NvimTreeOpenedFolderName guifg=#${config.colorscheme.colors.base05}
    '';

  };

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "nvim %F";
      icon = "nvim";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      terminal = true;
      type = "Application";
      categories = [ "Utility" "TextEditor" ];
    };
  };

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [ ".local/share/nvim/project_nvim" ];
    "/persist/home/brenix".files = [
      ".local/share/nvim/telescope-projects.txt"
      ".local/share/nvim/telescope-workspaces.txt"
      ".local/share/nvim/telescope_history"
    ];
  };
}
