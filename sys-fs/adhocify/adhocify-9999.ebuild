# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/quitesimpleorg/${PN}.git"

inherit git-r3 linux-info toolchain-funcs

DESCRIPTION="Tool which monitors for inotify events and executes script"
HOMEPAGE="https://github.com/quitesimpleorg/adhocify"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

CONFIG_CHECK="~INOTIFY_USER"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin adhocify
}
