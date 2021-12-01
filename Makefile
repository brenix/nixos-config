export NIX_REPO ?= https://github.com/brenix/nixos-config
export NIX_CONFIG ?=
export NIX_DISK ?=
export NIX_HOST ?=
export SSH_OPTIONS ?= -o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

ifndef NIX_CONFIG
$(error NIX_CONFIG is not set)
endif

switch:
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#$(NIX_CONFIG)" --upgrade

test:
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild test

install:
	@ssh $(SSH_OPTIONS) root@$(NIX_HOST) " \
		umount -R /mnt 2>/dev/null; \
		parted -s /dev/$(NIX_DISK) -- mklabel gpt; \
		parted -s /dev/$(NIX_DISK) -- mkpart ESP fat32 1MiB 512MiB; \
		parted -s /dev/$(NIX_DISK) -- mkpart primary 512MiB 100%; \
		parted -s /dev/$(NIX_DISK) -- set 1 esp on; \
		parted -s /dev/$(NIX_DISK) -- name 1 boot; \
		parted -s /dev/$(NIX_DISK) -- name 2 nixos; \
		mkfs.fat -F32 -n boot /dev/$(NIX_DISK)1; \
		mkfs.ext4 -m0 -F -L nixos /dev/$(NIX_DISK)2; \
		sleep 5; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		nix-shell -p git --run 'git clone $(NIX_REPO) /mnt/etc/nixos'; \
		nix-shell -p git nixFlakes --run 'nixos-install --impure --no-root-passwd --root /mnt --flake /mnt/etc/nixos#$(NIX_CONFIG)'; \
	"
