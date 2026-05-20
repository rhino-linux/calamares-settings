PREFIX = /etc/calamares
BRANDING = $(PREFIX)/branding/rhino

.PHONY: all install unicorn lomiri check-env

check-env:
ifndef ARCH
	$(error ARCH is undefined)
endif

MODULES = \
	modules/after_bootloader_context.conf \
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
	branding/Wizard.png

SETTINGS_CONF = settings.conf
DISPLAYMANAGER_CONF = modules/displaymanager.conf
EXTRA_MODULES =

ifeq ($(ARCH),x86_64)
	MODULES += modules/shellprocess_add386arch.conf
endif

all: unicorn

install: unicorn

unicorn: check-env
	$(MAKE) install-common

lomiri: SETTINGS_CONF = settings-lomiri.conf
lomiri: DISPLAYMANAGER_CONF = modules/displaymanager_lomiri.conf
lomiri: EXTRA_MODULES = modules/after_bootloader_context_lomiri.conf
lomiri: check-env
	$(MAKE) install-common \
		SETTINGS_CONF="$(SETTINGS_CONF)" \
		DISPLAYMANAGER_CONF="$(DISPLAYMANAGER_CONF)" \
		EXTRA_MODULES="$(EXTRA_MODULES)"

.PHONY: install-common

install-common:
	install -d $(DESTDIR)$(PREFIX)/modules
	install -d $(DESTDIR)$(BRANDING)/
	install -d $(DESTDIR)/usr/libexec/
	install -d $(DESTDIR)/usr/lib/$(ARCH)-linux-gnu/calamares/modules/
	install -Dm644 $(SETTINGS_CONF) $(DESTDIR)$(PREFIX)/settings.conf
	install -Dm644 $(MODULES) $(DESTDIR)$(PREFIX)/modules/
	install -Dm644 $(DISPLAYMANAGER_CONF) $(DESTDIR)$(PREFIX)/modules/displaymanager.conf
	if [ -n "$(EXTRA_MODULES)" ]; then \
		install -Dm644 $(EXTRA_MODULES) $(DESTDIR)$(PREFIX)/modules/; \
	fi
	install -Dm644 $(THEME) $(DESTDIR)$(BRANDING)
	install -Dm755 $(LIBEXEC_SCRIPTS) $(DESTDIR)/usr/libexec/

	cp -r $(PY_MODULES) $(DESTDIR)/usr/lib/$(ARCH)-linux-gnu/calamares/modules/
	cp $(DESTDIR)/usr/lib/$(ARCH)-linux-gnu/calamares/modules/automirror/automirror.conf $(DESTDIR)$(PREFIX)/modules/
