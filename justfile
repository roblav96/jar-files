# use with https://github.com/casey/just

# set shell := ["/usr/bin/env", "-i", "/usr/local/bin/bash", "-l", "-c"]

extractAllJars:
	rm -rfv build
	bash gradlew dependencies --configuration testCompileOnly
	bash gradlew extractAllJars

pbcopyJars:
	fd -uu --absolute-path --search-path=build --type=file --extension=jar | pbcopy
