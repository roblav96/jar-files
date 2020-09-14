# use with https://github.com/casey/just

extractAllJars:
# 	rm -rf build
	bash gradlew dependencies --configuration testCompileOnly
	bash gradlew extractAllJars

pbcopyJars:
	fd -uu --absolute-path --search-path=build --type=file --extension=jar | pbcopy
