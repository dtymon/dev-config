autoload add-zsh-hook

chdir_post_hook() { emulate -L zsh; ls -aCFN }
add-zsh-hook chpwd chdir_post_hook
