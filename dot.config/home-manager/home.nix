{ nur-babarot, ... }:

{
  home.username = "oppara";
  home.homeDirectory = "/Users/oppara";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [
    nur-babarot.claude-recall
  ];

  home.file.".claude/skills/claude-recall".source =
    "${nur-babarot.claude-recall}/share/claude-plugin/claude-recall";
}
