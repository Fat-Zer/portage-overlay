# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit distutils-r1 eutils

DESCRIPTION="Format-agnostic tabular dataset library"
HOMEPAGE="https://github.com/jazzband/tablib"
SRC_URI="https://github.com/jazzband/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( dev-python/MarkupPy[${PYTHON_USEDEP}]
		dev-python/odfpy[${PYTHON_USEDEP}]
		dev-python/openpyxl[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
		dev-python/xlrd[${PYTHON_USEDEP}]
		dev-python/xlwt[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# setuptools is unable to detect version
	sed -i -e "/setup(/a\\    version='${PV}'," \
		-e "/use_scm_version/s/True/False/" \
		setup.py || die "sed failed for setup.py"

	# Disable pytest options
	sed -i '/addopts/d' pytest.ini || die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "support cli" dev-python/tabulate
	optfeature "support html" dev-python/MarkupPy
	optfeature "support ods" dev-python/odfpy
	optfeature "support pandas" dev-python/pandas
	optfeature "support xls" dev-python/xlrd dev-python/xlwt
	optfeature "support xlsx" dev-python/openpyxl
	optfeature "support yaml" dev-python/pyyaml
}
