{modulesPath, ...}: {
  imports =
    # Default system installer configuration
    [(modulesPath + "/installer/scan/not-detected.nix")]
    ++
    # Shared configuration across all machines
    [(import ../shared)]
    ++
    # Hardware configuration
    [(import ./hardware.nix)]
    ++
    # Partition table
    [(import ./partitions.nix)];
}
