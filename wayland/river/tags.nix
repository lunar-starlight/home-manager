{ lib, ... }:
let
  non = "None	";
  ctl = "Control	";
  mod = "Super	";
  sft = "Shift	";
  alt = "Alt		";
  ms  = "Super+Shift	";
  ma  = "Super+Alt	";
  mc  = "Super+Control";
  mas = "Super+Alt+Shift";
  mac = "Super+Alt+Control";
  msc = "Super+Shift+Control";
  pow2 = lib.fix (self: n: if n != 0 then 2 * (self (n - 1)) else 1);
in {
  wayland.windowManager.river.settings.map.normal = 
    builtins.listToAttrs (lib.lists.flatten (lib.lists.imap0
      (i: key: [
        (lib.attrsets.nameValuePair "${mod}	${key}		" "set-focused-tags ${toString (pow2 i)}")
        (lib.attrsets.nameValuePair "${ms}	${key}		" "set-view-tags ${toString (pow2 i)}")
        (lib.attrsets.nameValuePair "${mc}	${key}		" "toggle-focused-tags ${toString (pow2 i)}")
        (lib.attrsets.nameValuePair "${msc}	${key}		" "toggle-view-tags ${toString (pow2 i)}")])
      [ "Minus" "7" "5" "3" "1" "9" "0" "2" "4" "6" ])) //
    {
      "${mod}	8		" = "set-focused-tags 4294967295";
      "${ms}	8		" = "set-view-tags 4294967295";
      "${alt}	Tab		" = "focus-previous-tags";
    };
}
