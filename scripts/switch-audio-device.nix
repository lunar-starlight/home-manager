{ pkgs, ... }:
pkgs.writeShellScriptBin "switch-audio-device" ''
BACK="alsa_output.pci-0000_09_00.3.HiFi__Line1__sink"
FRONT="alsa_output.pci-0000_09_00.3.HiFi__Headphones__sink"
HDMI="alsa_output.pci-0000_07_00.1.hdmi-stereo-extra3"
HEADPHONES=$BACK
SPEAKERS=$HDMI

CURRENT_OUTPUT=($(${pkgs.pulseaudio}/bin/pactl get-default-sink))
if [[ $CURRENT_OUTPUT = $HEADPHONES ]]
then
        NEW_OUTPUT=$SPEAKERS
else
	NEW_OUTPUT=$HEADPHONES
fi
${pkgs.pulseaudio}/bin/pactl set-default-sink $NEW_OUTPUT
''
