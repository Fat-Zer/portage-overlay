# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/zulip/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="An implementation of a LDAPObject to fake a ldap server"
HOMEPAGE="https://github.com/zulip/fakeldap"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/pyldap[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove unneeded requirement
	sed -i '/setup_requires/d' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests -v || die "tests failed with ${EPYTHON}"
}