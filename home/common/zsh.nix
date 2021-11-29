{
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  enableSyntaxHighlighting = true;
  autocd = true;
  dotDir = ".config/zsh";
  dirHashes = {
    docs = "$HOME/Documents";
    vids = "$HOME/Videos";
    dl = "$HOME/Downloads";
  };
  history =
    let
      historySize = 1000000;
    in
    {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = historySize;
      share = true;
      size = historySize;
    };
  shellGlobalAliases = {
    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";
    "......" = "../../../../..";
    "......." = "../../../../../..";
    "........" = "../../../../../../..";
  };
}
