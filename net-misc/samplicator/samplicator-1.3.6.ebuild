# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="UDP packets forwarder and duplicator"
HOMEPAGE="https://github.com/sleinen/samplicator"
SRC_URI="https://github.com/sleinen/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="acct-user/samplicator"

src_install() {
	default

	doman "${FILESDIR}"/samplicator.8

	newinitd "${FILESDIR}"/samplicator.initd samplicator
	newconfd "${FILESDIR}"/samplicator.confd samplicator
	systemd_dounit "${FILESDIR}"/samplicator.service
}

pkg_postinst() {
	ewarn ""
	ewarn "Don't specify the receiver on the command line, because it will get all packets."
	ewarn "Instead of this, specify it in a config file; defined in such way it will only get packets with a matching source."
	ewarn ""

	einfo "For every receiver type create a file in directory /etc/samplicator (see example below)"
	einfo "and specify the path to it in variable CONFIG of the corresponding initscript config file in /etc/conf.d/"
	einfo ""
	einfo "Receiver config examples: "
	einfo ""
	einfo "    /etc/samplicator/netflow:"
	einfo "    10.0.0.0/255.0.0.0:1.1.1.1/9996 2.2.2.2/9996 3.3.3.3/9996"
	einfo ""
	einfo "    /etc/samplicator/syslog:"
	einfo "    10.0.0.0/255.255.0.0:2.2.2.2/514 3.3.3.3/514"
	einfo ""
	einfo "    /etc/samplicator/snmp:"
	einfo "    10.0.0.0/255.255.255.255:3.3.3.3/162"
}
