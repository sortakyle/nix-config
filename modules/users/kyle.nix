{
  flake.modules.nixos.user-kyle = {
    users.users = {
      kyle = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = ["wheel"];
        openssh.authorizedKeys.keys = [
          # TODO: get rid of these two
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCUqWREltR1JJTkV2qqE31zkJx+cWd+WVVVcSyAHaQn9bYp/EP9yLOpGdDjL4XbhuFwXeCxL/LoUePc+WWTCzQNFARCuzL8wu+4Ow3yB71LBg4MkgXQAFZs45Iq1OqiZVy3qrsadvb/DCZk7qN/c+2siHvHqVZtb9cLJn34U2wR4j5XO/ygNVb2fgKRwcoQxiX9EZ+fAljXMQGJQ3iehAwhQQKK66O0avJX7D55BcWXhd/jtGqIwvjYBHooQo0XdeSKA3i1Wiwp/JGJZ8VoJDe2Urh/AxBGUmiGOoCiYsJtyx83a0Xyg6XG3elfg4dxeE2dWXd0MMRhoo6nOB+YdI0/NA24GnIvlmeLxaAxrn5abObI3YpAOWP4tZu4n9DPWxSZNEjXNwaH+HwXJtBtuhVISLoksn8kAu+tIgO2CD+5O4rMGJWS9dhBGPTr6fBiaEWV7yP9gYh/wkGXNqfMU27paoFIL6nOXzpmpUbd9cxnsm687e+n5/imaCouPW3ah9U= kyle@DESKTOP-6KIFQ02"
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnnipZsVmz/mN8fsZVBpKFUjT+ilUOYKjxdnuUw2BjdjBkvVutYlgH+HgbA08P9UjIOAt+IRiYRNnTfTlj7jjsya6jthSunyT3GciuaBnn+XmcVJwKv61aIVc6d3mj/TCo9XqwdbKpMsqVOVBdW5KltC0poiq2dE3ESejEH+sGO9CRW5ms4vzX8b/Vj6mUcwoX9NBhebMUwD1HMn5l2kwUaT2pri1TZmskg1oenVfsODd5Ss019tETRskgbROGSqwvZJ3nXVJAuUx7JodDBGp5v8Qb/D4TjxkjnUfl8peQkGiWI7cEm64ljp525CiGgd2cF94RNx1qq74DqpYHkTAGqk822gFoKPm68OiIuPXvTn7seHtr9bA7uID0zV+gS8gVWkGicdssKgc6euuXAwNeDJLeRvr+PG72QxV7/MNDjXvj6ZbSPuIg+eA8KBCjVPEmcWypEYuv5gImgfm5YSZ+dvEo60NAR6eLWll4UjzU6h6s+TWYf5NHFEgupB9DnfE= kyle@Pegasus"
          # self-identifiable key
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIER+H2VfcVnxFNA7nZ1xZoPKp93LPnWvrnGVZ3Bux4FZ"
        ];
        hashedPassword = null; # TODO: sops?
      };
    };
  };

  flake.modules.homeManager.user-kyle = {
    home = {
      username = "kyle";
      homeDirectory = "/home/kyle";
    };
  };
}
