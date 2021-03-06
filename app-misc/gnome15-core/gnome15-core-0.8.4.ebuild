EAPI="3"

inherit linux-info

MY_PN="gnome15"
MY_P="${MY_PN}-${PV}"
MY_S="${WORKDIR}/${MY_P}"

DESCRIPTION="Gnome tools for the Logitech G Series Keyboards And Z-10 Speakers"
HOMEPAGE="http://www.gnome15.org/"
SRC_URI="http://www.gnome15.org/downloads/Gnome15/Required/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ayatana cairo g15 g19 gnome lg4l-module systray title"

# seems these were moved from g19d here:
#		 dev-python/pyusb
#		 dev-python/python-uinput

RDEPEND="dev-python/pygtk
		 dev-python/gconf-python
		 dev-python/dbus-python
		 dev-python/libgtop-python
		 dev-python/lxml
		 dev-python/pycairo
		 dev-python/imaging
		 dev-python/python-xlib
		 dev-python/librsvg-python
		 dev-python/pyalsa
		 dev-python/pyalsaaudio
		 dev-python/feedparser
		 dev-python/pyinotify
		 dev-python/libwnck-python
		 dev-python/pyusb
		 dev-python/python-uinput
		 dev-python/python-virtkey
		 sys-fs/udev
		!app-misc/gnome15-indicator
		!app-misc/gnome15-panel-applet
		!app-misc/gnome15-systemtray
cairo? ( x11-misc/cairo-clock )
g15?   ( dev-libs/libg15-gnome15 )
g19?   ( dev-python/pylibg19 )
gnome? ( gnome-base/libgnomeui
		 dev-python/gnome-desktop-python
		 dev-python/gnome-applets-python
		 dev-python/pygobject )
systray? ( dev-python/pygobject )
lg4l-module? ( dev-python/pyinputevent
			   app-misc/lgsetled )
title? ( dev-python/setproctitle )"
DEPEND="${RDEPEND}"

pkg_setup() {
	ERROR_INPUT_UINPUT="INPUT_UINPUT is required for g15-desktop-service to work"
	CONFIG_CHECK="~INPUT_UINPUT"
	check_extra_config
}

src_configure() {
	cd ${MY_S} && econf \
		$(use_enable ayatana indicator) \
		$(use_enable gnome applet) \
		$(use_enable systray systemtray) \
		--enable-udev=/etc/udev/rules.d \
		|| die "econf failed"
}

src_compile() {
	cd ${MY_S} && emake || die "emake failed"
}

src_install() {
	cd ${MY_S} && emake DESTDIR="${D}" install || die "emake install failed"
}

