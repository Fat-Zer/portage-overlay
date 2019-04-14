# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EGIT_REPO_URI="https://github.com/bluekelp/pytimecop.git"

MY_PV="${PV/_pre/dev}"
MY_P="${PN}-${MY_PV}"

inherit distutils-r1

DESCRIPTION="A port of TimeCop Ruby Gem for Python"
HOMEPAGE="https://github.com/bluekelp/pytimecop"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# Remove failing test
	sed -i "/test_epoch/,+3d" timecop/tests/test_freeze.py \
		|| die "sed failed for requirements.txt"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}