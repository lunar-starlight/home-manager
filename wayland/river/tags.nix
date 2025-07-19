{ lib, ... }:
let
  non = "None               ";
  ctl = "Control            ";
  mod = "Super              ";
  sft = "Shift              ";
  alt = "Alt                ";
  ms  = "Super+Shift        ";
  ma  = "Super+Alt          ";
  mas = "Super+Alt+Shift    ";
  mac = "Super+Alt+Control  ";
  msc = "Super+Shift+Control";
in {
  wayland.windowManager.river.settings.map = {
    normal =
      lib.lists.imap0
        (key: {
          "${mod} ${key}" = "set-focused-tags		${2^i}"
          "${ms}  ${key}" = "set-view-tags		${2^i}"
          "${mc}  ${key}" = "toggle-focused-tags	${2^i}"
          "${msc} ${key}" = "toggle-view-tags		${2^i}"
        })
        [ "-" "7" "5" "3" "1" "9" "0" "2" "4" "6" ];
#{
#      "${non} 		" = "";
#    };
  };
}
