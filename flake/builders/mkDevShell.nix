{ pkgs, name, system, args, ... }:

let

  checksShellHookFn = args.checksShellHook or (system: "");
  packagesFn = args.packages or (pkgs: [ ]);

in

pkgs.mkShell {
  inherit name;
  buildInputs = with pkgs; [
    # banner printing on enter
    figlet
    lolcat
  ] ++ (packagesFn pkgs);
  shellHook = ''
    figlet ${name} | lolcat --freq 0.5
  '' + (checksShellHookFn system);
}
