{ ... }:
{
  services.gammastep = {
    enable = true;
    provider = "manual";
    longitude = 46.1;
    latitude = 14.5;
    temperature = {
      day = 2800;
      night = 2800;
    };
  };
}
