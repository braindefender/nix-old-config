{ config, lib, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;

      history = {
        save = 10000;
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      dotDir = ".config/zsh";

      initExtra = ''
        FZF_TAB_COMMAND=(
	  ${lib.getExe pkgs.fzf} 
	  --ansi 
	  --multi 
	  --cycle
	  --height="50%" 
	  --layout=reverse 
	  --tiebreak=begin 
	  --bind=tab:down,btab:up,change:top,ctrl-space:toggle
	)

	ZSH_AUTOSUGGEST_USE_ASYNC="true"
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
	ZSH_HIGHLIGHT_MAXLENGTH=512

        any-nix-shell zsh --info-right | source /dev/stdin

        function run() {
	  nix run nixpkgs#$@
	}

	function extract() {
	  if [ -z "$1" ]; then
            # display usage if no parameters given
            echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso>"
            echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
          else
           for n in "$@"
           do
             if [ -f "$n" ] ; then
               case "''${n%,}" in
                 *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                              tar xvf "$n"       ;;
                 *.lzma)      unlzma ./"$n"      ;;
                 *.bz2)       bunzip2 ./"$n"     ;;
                 *.cbr|*.rar) unrar x -ad ./"$n" ;;
                 *.gz)        gunzip ./"$n"      ;;
                 *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
                 *.z)         uncompress ./"$n"  ;;
                 *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                              7z x ./"$n"        ;;
                 *.xz)        unxz ./"$n"        ;;
                 *.exe)       cabextract ./"$n"  ;;
                 *.cpio)      cpio -id < ./"$n"  ;;
                 *.cba|*.ace) unace x ./"$n"     ;;
                 *.zpaq)      zpaq x ./"$n"      ;;
                 *.arc)       arc e ./"$n"       ;;
                 *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                                   extract "$n.iso" && \rm -f "$n" ;;
                 *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                                   mv ./"$n.tmp" ./"''${n%.*zlib}" && rm -f "$n"   ;;
                 *)
                              echo "extract: '$n' - unknown archive method"
                              return 1
                              ;;
               esac
             else
               echo "'$n' - file doesn't exist"
               return 1
             fi
           done
        fi
	}
      '';

      envExtra = ''
	export FZF_DEFAULT_OPTS="
          --color fg:#6c7086
          --color fg+:#1e1e2e
          --color bg:#313244
          --color bg+:#cba6f7
          --color hl:#f5e0dc
          --color hl+:#313244
          --color info:#585b70
          --color marker:#1e1e2e
          --color prompt:#a6e3a1
          --color spinner:#f38ba8
          --color pointer:#1e1e2e
          --color header:#cba6f7
          --color preview-fg:#f5e0dc
          --color preview-bg:#1e1e2e
          --color gutter:#313244
          --color border:#11111b
          --border
          --prompt 'λ '
          --pointer ''
          --marker ''
        "
      '';

      zplug = {
        enable = true;
	zplugHome = "${config.xdg.configHome}/zsh/zplug";
	plugins = [
	  { name = "Aloxaf/fzf-tab"; }
	  { name = "zdharma-continuum/fast-syntax-highlighting"; }
	  { name = "zsh-users/zsh-completions"; }
	  { name = "zsh-users/zsh-autosuggestions"; }
	  { name = "zsh-users/zsh-history-substring-search"; }
	  { name = "hlissner/zsh-autopair"; }
	  { name = "chisui/zsh-nix-shell"; }
	];
      };

      shellAliases = with pkgs; {
        # Base
	q = "exit";
	c = "clear";
	m = "mkdir -p";
	v = "${lib.getExe nvim}";
	cat = "${lib.getExe bat} -p";
	size = "du -sh";
	# TODO: add dust (pkgs: du-dust)
	hx = "helix";

        # Exa instead of ls
        l = "${lib.getExe exa} -l --group-directories-first --time-style long-iso --no-user --icons";
        ll = "${lib.getExe exa} -la --group-directories-first --time-style long-iso --no-user --icons";
        la = "${lib.getExe exa} -la --group-directories-first --time-style long-iso --no-user --icons";
	tree = "${lib.getExe exa} --tree --icons --level=2";
	treee = "${lib.getExe exa} --tree --icons --level=3";

        # ZSH
	s = "source ~/.zshrc";

	# Git
	g = "git";
	push = "git push";
	pull = "git pull";
	fetch = "git fetch";
	commit = "git add . && git commit -m";

	# YouTube (download video and/or audio)
	ytv = "${lib.getExe yt-dlp} --format \"bv*+ba/b\"";
	yta = ''
          ${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
	'';

        # NixOS
	cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
	bloat = "nix path-info -Sh /run/current-system";

        # Others
      };
    };
  };
}
