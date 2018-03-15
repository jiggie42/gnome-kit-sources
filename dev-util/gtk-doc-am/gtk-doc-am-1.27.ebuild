# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME_ORG_MODULE="gtk-doc"

inherit gnome.org

DESCRIPTION="Automake files from gtk-doc"
HOMEPAGE="http://www.gtk.org/gtk-doc/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x64-cygwin ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND=">=dev-lang/perl-5.18"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	!<dev-util/gtk-doc-${GNOME_ORG_PVP}
"
# This ebuild doesn't even compile anything, causing tests to fail when updating (bug #316071)
RESTRICT="test"

src_configure() {
	# Replicate AC_SUBST
	sed -e "s:@PYTHON@:/usr/bin/env python:g" -e "s:@VERSION@:${PV}:g" \
		-e "s:@PYTHON_PACKAGE_DIR@:/usr/share/gtk-doc/python:g" \
		"${S}/gtkdoc-rebase.in" > "${S}/gtkdoc-rebase" || die "sed failed!"
}

src_compile() {
	:
}

src_install() {
	dobin gtkdoc-rebase

	insinto /usr/share/aclocal
	doins gtk-doc.m4
}
