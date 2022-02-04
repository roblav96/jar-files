#!/usr/bin/env just --justfile
# https://github.com/casey/just

set shell := ["bash", "-uc"]

_default :
	@just --dump



reset +folders :
	rm -r -f {{folders}}
	mkdir -p {{folders}}

dependencies :
	./gradlew dependencies --configuration testCompileOnly

extract-all-jars :
	just reset jar-files
	just dependencies
	./gradlew extractAllJars
	find jar-files -type f -name lint.jar -print -delete
	tree -N -d jar-files

pbcopy-out-paths :
	rm -r -f out-files
	cp -r jar-files out-files
	tree -N -d out-files
	fd -uu --search-path=out-files -tf -e jar -a | sed -e '/-ktx\./d' -e '/ktor-/d' | pbcopy
