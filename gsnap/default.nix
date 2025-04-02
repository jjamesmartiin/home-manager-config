{
  home.file = {
    ".config/gSnap/layouts.json " = {
      text = builtins.readFile ./layouts.json;
      force = true;
    };
  };
}
