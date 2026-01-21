{ pkgs, ... }:
let
  non = "None	";
  ctl = "Control	";
  mod = "Super	";
  sft = "Shift	";
  alt = "Alt	";
  ms  = "Super+Shift	";
  ma  = "Super+Alt	";
  mc  = "Super+Control";
  mas = "Super+Alt+Shift";
  mac = "Super+Alt+Control";
  msc = "Super+Shift+Control";
  spawn = "spawn '${pkgs.uwsm}/bin/uwsm app --";
  fnkeys = {
    "${non}XF86AudioRaiseVolume	" = "${spawn} \"pactl set-sink-volume @DEFAULT_SINK@ +5%\"'";
    "${non}XF86AudioLowerVolume	" = "${spawn} \"pactl set-sink-volume @DEFAULT_SINK@ -5%\"'";
    "${non}XF86AudioMute	" = "${spawn} \"pactl set-sink-mute @DEFAULT_SINK@ toggle\"'";
    "${non}XF86MonBrightnessUp	" = "${spawn} \"brightnessctl set +5%\"'";
    "${non}XF86MonBrightnessDown	" = "${spawn} \"brightnessctl set 5%-\"'";
  };
in {
  wayland.windowManager.river.settings = {
    declare-mode = [
      "normal"
    ];
    map = {
      normal = {
        "${non}	Print		" = "${spawn} \"killall slurp || grimshot copy area\"'";
        "${mod}	Space		" = "${spawn} fuzzel'";
        "${mod}	f12		" = "${spawn} alacritty'";
        "${ms}	f12		" = "${spawn} alacritty --class popup'";

        "${ms}	Q		" = "close";
        "${mod}	Return		" = "zoom";
        "${mod}	F		" = "toggle-fullscreen";
        "${ms}	F		" = "toggle-float";
        "${mod}	Backspace	" = "focus-output next";
        "${ms}	Backspace	" = "send-to-output -current-tags next";

        "${mod}	H		" = "focus-view left";
        "${mod}	J		" = "focus-view down";
        "${mod}	K		" = "focus-view up";
        "${mod}	L		" = "focus-view right";
        "${mod}	N		" = "focus-view next";
        "${mod}	P		" = "focus-view previous";

        "${ms}	H		" = "swap left";
        "${ms}	J		" = "swap down";
        "${ms}	K		" = "swap up";
        "${ms}	L		" = "swap right";
        "${ms}	N		" = "swap next";
        "${ms}	P		" = "swap previous";

        "${ma}	H		" = "move left 100";
        "${ma}	J		" = "move down 100";
        "${ma}	K		" = "move up 100";
        "${ma}	L		" = "move right 100";

        "${mas}	H		" = "resize horizontal -100";
        "${mas}	J		" = "resize vertical 100";
        "${mas}	K		" = "resize vertical -100";
        "${mas}	L		" = "resize horizontal 100";

        "${mac}	H		" = "snap left";
        "${mac}	J		" = "snap down";
        "${mac}	K		" = "snap up";
        "${mac}	L		" = "snap right";

        "${mod}	f11		" = "send-to-output -current-tags next";
      } // fnkeys;
    };
    map-pointer = {
      normal = {
        "${mod}BTN_LEFT	" = "move-view";
        "${mod}BTN_RIGHT	" = "resize-view";
      };
    };
  };
}
