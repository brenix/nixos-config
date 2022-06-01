{ inputs }:

final: prev: {
  calicoctl = prev.callPackage ./calicoctl { };
  dash-font = prev.callPackage ./dash-font { };

  # Add `--no-sandbox` flag to authy due to issues identifying GPU
  authy = prev.authy.overrideAttrs (oldAttrs: rec {
    postFixup = ''
      makeWrapper ${prev.electron_9}/bin/electron $out/bin/authy \
        --add-flags $out/resources/app.asar \
        --add-flags "--no-sandbox"
    '';
  });
}