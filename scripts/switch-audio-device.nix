{ pkgs, ... }:
pkgs.writeShellScriptBin "switch-audio-device" ''
HEADPHONES="alsa_output.pci-0000_09_00.3.HiFi__Line1__sink"
SPEAKERS="alsa_output.pci-0000_09_00.3.HiFi__Headphones__sink"
HDMI="alsa_output.pci-0000_07_00.1.hdmi-stereo-extra4"

CURRENT_OUTPUT=($(${pkgs.pulseaudio}/bin/pactl get-default-sink))
if [[ $CURRENT_OUTPUT = $SPEAKERS ]]
then
        NEW_OUTPUT=$HDMI
else
	NEW_OUTPUT=$SPEAKERS
fi
${pkgs.pulseaudio}/bin/pactl set-default-sink $NEW_OUTPUT
''
