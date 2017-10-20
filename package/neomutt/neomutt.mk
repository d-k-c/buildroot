################################################################################
#
# neomutt
#
################################################################################

NEOMUTT_VERSION = c90241bbdf1dd891a02e31b74abdadaff89e0920
NEOMUTT_SITE = git://github.com/neomutt/neomutt.git
NEOMUTT_SITE_METHOD = git
NEOMUTT_LICENSE = GPL-2.0+
NEOMUTT_LICENSE_FILES = GPL
NEOMUTT_DEPENDENCIES = ncurses libiconv
NEOMUTT_CONF_OPTS = --disable-doc

# SSL support is only used by imap or pop3 module
ifeq ($(BR2_PACKAGE_OPENSSL),y)
NEOMUTT_DEPENDENCIES += openssl
NEOMUTT_CONF_OPTS += --ssl
else
NEOMUTT_CONF_OPTS += --disable-ssl
endif

ifeq ($(BR_PACKAGE_LIBIDN),y)
NEOMUTT_DEPENDENCIES += libidn
else
NEOMUTT_CONF_OPTS += --disable-idn
endif

NEOMUTT_CONF_OPTS += --with-mailpath=/var/mail

define NEOMUTT_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		./configure.autosetup \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--with-ncurses=$(STAGING_DIR) \
		--with-nls=$(STAGING_DIR) \
		$(NEOMUTT_CONF_OPTS) \
	)
endef
			
define NEOMUTT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define NEOMUTT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

define NEOMUTT_VAR_MAIL
	mkdir -p $(TARGET_DIR)/var
	ln -sf /tmp $(TARGET_DIR)/var/mail
endef
NEOMUTT_POST_INSTALL_TARGET_HOOKS += NEOMUTT_VAR_MAIL

$(eval $(generic-package))
