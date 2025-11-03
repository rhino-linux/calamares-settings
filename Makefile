PREFIX = /etc/calamares
BRANDING = $(PREFIX)/branding/rhino
ARCH ?= $(shell uname -m)

# We love debian style names.
ifeq ($(ARCH),amd64)
  ARCH := x86_64
endif

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
	modules/shellprocess_oemprep.conf \
	modules/umount.conf \
	modules/unpackfs.conf \
	modules/users.conf \
	modules/users.conf.oem \
	modules/welcome.conf

PY_MODULES = py-modules-$(ARCH)/automirror/

LIBEXEC_SCRIPTS = libexec-scripts/fixconkeys-part1 \
				  libexec-scripts/fixconkeys-part2

THEME = \
	branding/Base.png \
	branding/branding.desc \
	branding/icon.png \
	branding/logo.png \
	branding/rhino-calamares.png \
	branding/rhinopkg.png \
	branding/show.qml \
	branding/System.png \
	branding/Unicorn.png \
	branding/waves.png \
	branding/welcome.png \
	branding/Wizard.png \

ifeq ($(ARCH),x86_64)
	MODULES += modules/shellprocess_add386arch.conf
endif

all: install

install:
	install -d $(DESTDIR)$(PREFIX)/modules
	install -d $(DESTDIR)$(BRANDING)/
	install -d $(DESTDIR)/usr/libexec/
	install -d $(DESTDIR)/usr/lib/$(ARCH)-linux-gnu/calamares/modules/
	install -Dm644 settings.conf $(DESTDIR)$(PREFIX)/
	install -Dm644 $(MODULES) $(DESTDIR)$(PREFIX)/modules/
	install -Dm644 $(THEME) $(DESTDIR)$(BRANDING)
	install -Dm644 $(LIBEXEC_SCRIPTS) $(DESTDIR)/usr/libexec/

	cp -r $(PY_MODULES) $(DESTDIR)/usr/lib/$(ARCH)-linux-gnu/calamares/modules/

.PHONY: all install
