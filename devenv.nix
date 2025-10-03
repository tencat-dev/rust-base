{ pkgs, lib, config, inputs, ... }:

{
  cachix.enable = true;
  dotenv.disableHint = true;

  # https://devenv.sh/basics/
  env = {};

  # https://devenv.sh/packages/
 packages = with pkgs; [
      git
  ];

  # https://devenv.sh/languages/
  languages.rust = {
      channel = "stable";
      enable = true;
      version = "1.90.0";
      targets = ["x86_64-unknown-linux-gnu"];
      components = ["rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" "rust-src"];
    };

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
#  scripts.hello.exec = ''
#    echo hello from $GREET
#  '';

  # https://devenv.sh/basics/
  enterShell = ''
    git --version
    echo "Rust version: $(rustc --version)"
    echo "Cargo version: $(cargo --version)"
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
