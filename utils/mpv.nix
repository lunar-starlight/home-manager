{ pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
  };

  programs.mpv = {
    enable = true;

    config = {
      ytdl-format = "bestvideo[height<=?720][fps<=?30][vcodec!=?vp9]+bestaudio/best";
    };

    scriptOpts = {
      ytdl_hook = {
        ytdl_path = "${pkgs.yt-dlp}/bin/yt-dlp";
      };
    };
  };
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/mpegurl" = "mpv.desktop";
        "application/x-mpegurl" = "mpv.desktop";
        "audio/mpegurl" = "mpv.desktop";
        "audio/x-mpegurl" = "mpv.desktop";
      };
    };
    #desktopEntries.mpv = {
    #  name = "mpv";
    #  exec = "${pkgs.mpv}/bin/mpv";
    #};
  };
}
