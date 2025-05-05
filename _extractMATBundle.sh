#!/bin/bash
#DO NOT EDIT WITH WINDOWS
tooling_jar=tooling-cli-3.7.0.jar
input_cache_path=./input-cache
mat_bundle=./bundles/mat/CMS68/CMS68FHIR-R1-MeasureExport/CMS68FHIR-v0.3.000-FHIR.json

set -e

tooling=$input_cache_path/$tooling_jar
if test -f "$tooling"; then
	echo Extracting bundle $mat_bundle
	java -jar $tooling -ExtractMatBundle $mat_bundle

else
	tooling=../$tooling_jar
	echo $tooling
	if test -f "$tooling"; then
		java -jar $tooling -ExtractMatBundle $mat_bundle
	else
		echo cqf Tooling jar NOT FOUND in input-cache or parent folder.  Please run _updateCQFTooling.  Aborting...
	fi
fi
