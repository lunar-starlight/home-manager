{ ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      { profile.name = "pink-pear";
        profile.outputs = [
          {
            criteria = "AOC CU34V5C 1UJS3HA000208";
            position = "0,730";
          }
          {
            criteria = "AOC Q27P1B GNXK9HA097193";
            position = "3440,0";
            transform = "90";
           }
        ];
      }
    ];
  };
}
