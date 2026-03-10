{ ... }:

{
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Jonathan Hart";
        email = "jonathan.e.hart@outlook.com";
      };

      pull = {
        rebase = true;
        ff = "only";
      };

      merge = {
        ff = false;
        log = 50;
      };

      commit.verbose = true;

      init.defaultBranch = "main";
    };
  };

  programs.gpg.enable = true;

}
