# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit distutils-r1

DESCRIPTION="Utilities for implementing Modified Preorder Tree Traversal"
HOMEPAGE="https://github.com/django-mptt/django-mptt"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-js-asset[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/mock-django[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" tests/manage.py test myapp --verbosity 2 || die "tests failed with ${EPYTHON}"
}
