{ inputs, lib, config, pkgs, ... }: 
{

    #direnv enable
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    #programs.bash.enable = true;
    # OR
    programs.zsh.enable = true;

    programs.zsh.shellAliases.mkp = "nix flake init -t github:tobias1012/project_template --arg name ";
    
    home.packages = with pkgs; [
        vscode
	keepassxc
	signal-desktop
	vim
	vimPlugins.LazyVim
    ];
}
