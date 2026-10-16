{ nur-babarot, ... }:

{
  home.username = "oppara";
  home.homeDirectory = "/Users/oppara";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [
    nur-babarot.claude-recall
  ];
}
