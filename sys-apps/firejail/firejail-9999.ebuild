# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils multilib bash-completion-r1 git-r3

DESCRIPTION="Sandbox program that reduces the risk of security breaches"
HOMEPAGE="https://firejail.wordpress.com/"
EGIT_REPO_URI="https://github.com/netblue30/${PN}.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="bash-completion +bind +chroot debug seccomp"

RDEPEND=">=sys-libs/libcap-2.24
	bash-completion? ( app-shells/gentoo-bashcomp )
	seccomp? ( sys-libs/libseccomp )"

DEPEND="virtual/os-headers
	${RDEPEND}"

src_prepare() {
	for dir in firejail firemon ftee lib libtrace;
	do
		# Remove -O2 flag
		sed -r '/\$\(HAVE_FATAL_WARNINGS\) -O2 /s/ -O2//' \
			-i "${S}"/src/"${dir}"/Makefile.in || die "sed for O2 flag strip on Makefile.in in src/${dir} failed"
		if ! use debug ; then
			sed -r '/CFLAGS \+= -ggdb/s/ -ggdb//' \
				-i "${S}"/src/"${dir}"/Makefile.in || die "sed for debug on Makefile.in in src/${dir} failed"
		fi
	done

	# Do not install shell completions
	sed '/bash-completion/d' -i Makefile.in || die "sed for bash-completion on Makefile.in failed"

	epatch_user
}

src_configure() {
	econf \
		$(use_enable bind) \
		$(use_enable chroot) \
		$(use_enable seccomp) \
		--libdir=/usr/$(get_libdir)
}

src_install() {
	default

	keepdir /etc/${PN}/

	use bash-completion && newbashcomp "${S}"/src/bash_completion/firejail.bash_completion firejail
	use bash-completion && newbashcomp "${S}"/src/bash_completion/firemon.bash_completion firemon
}