#!/bin/bash
#DO NOT EDIT WITH WINDOWS
#exit 1

r=releases
g=org.opencds.cqf
a=tooling-cli
v=3.7.0

dlurl='https://oss.sonatype.org/service/local/artifact/maven/redirect?r='${r}'&g='${g}'&a='${a}'&v='${v}''

echo ${dlurl}

input_cache_path=./input-cache/
tooling_jar=tooling-cli-3.7.0.jar

set -e
if ! type "curl" > /dev/null; then
	echo "ERROR: Script needs curl to download latest IG Tooling. Please install curl."
	exit 1
fi

tooling="$input_cache_path$tooling_jar"
if test -f "$tooling"; then
	echo "IG Tooling FOUND in input-cache"
	jarlocation="$tooling"
	jarlocationname="Input Cache"
	upgrade=true
else
	tooling="../$tooling_jar"
	upgrade=true
	if test -f "$tooling"; then
		echo "IG Tooling FOUND in parent folder"
		jarlocation="$tooling"
		jarlocationname="Parent Folder"
		upgrade=true
	else
		echo IG Tooling NOT FOUND in input-cache or parent folder...
		jarlocation="$input_cache_path$tooling_jar"
		jarlocationname="Input Cache"
		upgrade=false
	fi
fi

if $upgrade ; then
	message="Overwrite $jarlocation? [Y/N] "
else
	#echo Will place tooling jar here: $input_cache_path$tooling_jar
	echo Will place tooling jar here: $jarlocation
	message="Ok? [Y/N]"
fi

read -r -p "$message" response
if [[ "$response" =~ ^([yY])$ ]]; then
	echo "Downloading most recent tooling to $jarlocationname - it's ~110 MB, so this may take a bit"
#	wget "https://oss.sonatype.org/service/local/repositories/snapshots/content/org/opencds/cqf/tooling/1.0-SNAPSHOT/tooling-1.0-20200107.163002-6-jar-with-dependencies.jar" -O "$jarlocation"
	curl $dlurl -L -o "$jarlocation" --create-dirs
	echo "Download complete."
else
	echo cancel...
fi
