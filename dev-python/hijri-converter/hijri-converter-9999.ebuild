# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/dralshehri/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Hijri-Gregorian date converter"
HOMEPAGE="https://github.com/dralshehri/hijri-converter"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest
