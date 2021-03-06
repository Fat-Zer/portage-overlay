# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/peak/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Parallel S3 and local filesystem execution tool"
HOMEPAGE="https://github.com/peak/s5cmd"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin s5cmd
}
