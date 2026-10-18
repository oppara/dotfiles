{ nur-babarot, ax-pkg, ... }:

{
  home.username = "oppara";
  home.homeDirectory = "/Users/oppara";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [
    nur-babarot.claude-recall
    ax-pkg
  ];

  home.file.".claude/skills/claude-recall".source =
    "${nur-babarot.claude-recall}/share/claude-plugin/claude-recall";

  programs.agent-skills = {
    enable = true;
    sources.ax = {
      input = "ax";
      subdir = "skills";
    };
    skills.enable = [ "ax" ];
    targets.claude = {
      enable = true;
      structure = "link";
      dest = ".claude/skills";
    };
    targets.agents = {
      enable = true;
      structure = "link";
      dest = ".agents/skills";
    };
  };
}
