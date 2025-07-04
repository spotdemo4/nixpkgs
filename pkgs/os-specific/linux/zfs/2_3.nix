{
  callPackage,
  lib,
  nixosTests,
  stdenv,
  ...
}@args:

callPackage ./generic.nix args {
  # You have to ensure that in `pkgs/top-level/linux-kernels.nix`
  # this attribute is the correct one for this package.
  kernelModuleAttribute = "zfs_2_3";
  # check the release notes for compatible kernels
  kernelCompatible = kernel: kernel.kernelOlder "6.15";

  # this package should point to the latest release.
  version = "2.3.2";

  tests =
    {
      inherit (nixosTests.zfs) series_2_3;
    }
    // lib.optionalAttrs stdenv.isx86_64 {
      inherit (nixosTests.zfs) installer;
    };

  maintainers = with lib.maintainers; [
    adamcstephens
    amarshall
  ];

  hash = "sha256-+DqpIgHCVi0fDOqvKwaGXIiiXw8xEnlv2tgRwgLX9G8=";
}
