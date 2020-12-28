#!/usr/bin/env just --justfile
# https://github.com/casey/just

set shell := ["bash", "-cu"]

dependencies-tree :
	./gradlew dependencies --configuration testCompileOnly

extract-all-jars :
	rm -r -f jar-files
	./gradlew --info extractAllJars
	find jar-files -type f -name lint.jar -print -delete

jar-files-tree :
	tree -N -d jar-files

jar-files :
	just dependencies-tree
	just extract-all-jars
	just jar-files-tree

pbcopy-jars :
	fd -uu --absolute-path --search-path=jar-files --type=file --extension=jar | pbcopy



# extractAllJars :
# 	./gradlew dependencies --configuration testCompileOnly
# 	./gradlew extractAllJars
