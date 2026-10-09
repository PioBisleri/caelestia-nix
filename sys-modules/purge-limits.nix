{ pkgs, ... }: {

  systemd.user.services.purge-limits = {
    description = "purge - apply saved process limits (CPU/RAM) at login";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.purge}/bin/purge --apply-limits";
      # give autostarted apps a moment to exist before limiting them
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
    };
  };

}
