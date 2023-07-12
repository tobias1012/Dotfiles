{ inputs, lib, config, pkgs, ... }: 
{

    #direnv enable
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    # optional for nix flakes support in home-manager 21.11, not required in home-manager unstable or 22.05
    programs.direnv.nix-direnv.enableFlakes = true;

    programs.bash.enable = true;
    # OR
    programs.zsh.enable = true;
    
    home.packages = with pkgs; [
        vscode
    ];
}