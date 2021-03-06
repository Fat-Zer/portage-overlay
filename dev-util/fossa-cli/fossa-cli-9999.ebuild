# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/fossas/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="License and vulnerability analysis"
HOMEPAGE="https://github.com/fossas/fossa-cli"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test" # fails

PATCHES=( "${FILESDIR}/${PN}"-1.1.0-go.mod.patch
	"${FILESDIR}/${PN}"-1.1.0-go.sum.patch
	"${FILESDIR}/${PN}"-1.1.0-modules.txt.patch )

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	local GOVER
	GOVER="$(go version | cut -d' ' -f3)"
	LDFLAGS="-extldflags '-static' -X github.com/fossas/fossa-cli/cmd/fossa/version.version=${PV}
		-X github.com/fossas/fossa-cli/cmd/fossa/version.commit=$(git rev-parse HEAD)
		-X github.com/fossas/fossa-cli/cmd/fossa/version.goversion=${GOVER}
		-X github.com/fossas/fossa-cli/cmd/fossa/version.buildType=development"
	GOFLAGS="-v -x -mod=vendor" \
		go build -o fossa -ldflags="${LDFLAGS}" ./cmd/fossa || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin fossa
}
