# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/Salamek/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Converts cron expressions into human readable strings"
HOMEPAGE="https://github.com/Salamek/cron-descriptor"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${EPYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
