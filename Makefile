PREFIX = /etc/calamares
ARCH ?= $(shell uname -m)

MODULES = \
	modules/after_bootloader_context.conf \
	modules/automirror.conf \
	modules/before_bootloader_context.conf \
	modules/before_bootloader_mkdirs_context.conf \
	modules/bootloader.conf \
	modules/copy_vmlinuz_shellprocess.conf \
	modules/displaymanager.conf \
	modules/finished.conf \
	modules/fstab.conf \
	modules/grubcfg.conf \
	modules/locale.conf \
	modules/machineid.conf \
	modules/mount.conf \
	modules/oemid.conf \
	modules/packages.conf \
	modules/partition.conf \
	modules/pkgselect.conf \
	modules/pkgselect_context.conf \
	modules/pkgselect_snap_context.conf \
	modules/shellprocess_bug-LP\#1829805.conf \
	modules/shellprocess_fixconkeys_part1.conf \
	modules/shellprocess_fixconkeys_part2.conf \
	modules/shellprocess_fix_oem_uid.conf \
	modules/shellprocess_logs.conf \
	modules/shellprocess_oemprep.conf \
	modules/umount.conf \
	modules/unpackfs.conf \
	modules/users.conf \
	modules/users.conf.oem \
	modules/welcome.conf

# We love debian style names.
ifeq ($(ARCH),amd64)
  ARCH := x86_64
endif

ifeq ($(ARCH),x86_64)
	MODULES += modules/shellprocess_add386arch.conf
endif

all: install

install:
	install -d $(DESTDIR)$(PREFIX)/modules
	install -m644 settings.conf $(DESTDIR)$(PREFIX)/
	install -m644 $(MODULES) $(DESTDIR)$(PREFIX)/modules/

.PHONY: all install
