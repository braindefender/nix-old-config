{modulesPath, ...}: {
  imports = [
    # Default system installer configuration
    (modulesPath + "/installer/scan/not-detected.nix")
    # Shared configuration across all machines
    ../shared
    # Hardware configuration
    ./hardware.nix
    # Partition table
    ./partitions.nix
    # Display configuration
    ./display.nix
  ];
}
