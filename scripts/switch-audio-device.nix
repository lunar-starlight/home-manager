{ pkgs, ... }:
pkgs.writeShellScriptBin "switch-audio-device" ''
HEADPHONES="alsa_output.pci-0000_09_00.3.HiFi__Line1__sink"
SPEAKERS="alsa_output.pci-0000_09_00.3.HiFi__Headphones__sink"

CURRENT_OUTPUT=($(${pkgs.pulseaudio}/bin/pactl get-default-sink))
if [[ $CURRENT_OUTPUT = $HEADPHONES ]]
then
	NEW_OUTPUT=$SPEAKERS
else
	NEW_OUTPUT=$HEADPHONES
fi
${pkgs.pulseaudio}/bin/pactl set-default-sink $NEW_OUTPUT
''
