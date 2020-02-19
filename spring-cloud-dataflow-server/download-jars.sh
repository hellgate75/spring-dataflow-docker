#!/bin/sh
FOLDER="$(realpath "$(dirname "$0")")"
echo "FOLDER: $FOLDER"
echo "FILES: $(ls $FOLDER)"
if [ -e $FOLDER/env.sh ]; then
	chmod 777 $FOLDER/env.sh
	. $FOLDER/env.sh
else
	. /opt/spring-cloud-space/temp/env.sh
fi
if [ ! -e $OUTFOLDER ]; then
   mkdir -p $OUTFOLDER
fi

echo ""
#Download Spring Data Flow binaries
echo "Download Spring Data Flow binaries..."

if [ "" != "$1" ]; then
	SCDF_RELEASE="$1"
fi
if [ "" != "$2" ]; then
	SKIPPER_RELEASE="$2"
fi
echo ""
echo "Downloading server packages for Spring Cloud Data Flow Infrastructure (Dataflow: v. $SCDF_RELEASE  Skipper: v. $SKIPPER_RELEASE)"
echo ""
echo "Downloading executables for Spring Cloud Data Flow Server v. $SCDF_RELEASE"
curl -L https://repo1.maven.org/maven2/org/springframework/cloud/spring-cloud-dataflow-server/$SCDF_RELEASE/spring-cloud-dataflow-server-$SCDF_RELEASE.jar -o $OUTFOLDER/spring-cloud-dataflow-server-$SCDF_RELEASE.jar
echo ""
echo "Downloading executables for Spring Cloud Data Flow shell v. $SCDF_RELEASE"
curl -L https://repo1.maven.org/maven2/org/springframework/cloud/spring-cloud-dataflow-shell/$SCDF_RELEASE/spring-cloud-dataflow-shell-$SCDF_RELEASE.jar -o $OUTFOLDER/spring-cloud-dataflow-shell-$SCDF_RELEASE.jar
echo ""
echo "Downloading executables for Spring Cloud Skipper Server v. $SKIPPER_RELEASE"
curl -L https://repo1.maven.org/maven2/org/springframework/cloud/spring-cloud-skipper-server/$SKIPPER_RELEASE/spring-cloud-skipper-server-$SKIPPER_RELEASE.jar -o $OUTFOLDER/spring-cloud-skipper-server-$SKIPPER_RELEASE.jar
echo "Downloading executables for Spring Cloud Skipper Shell v. $SKIPPER_RELEASE"
echo ""
curl -L https://repo1.maven.org/maven2/org/springframework/cloud/spring-cloud-skipper-shell/$SKIPPER_RELEASE/spring-cloud-skipper-shell-$SKIPPER_RELEASE.jar -o $OUTFOLDER/spring-cloud-skipper-shell-$SKIPPER_RELEASE.jar
echo "Download of Spring Cloud Data Flow Infrastructure (Dataflow: v. $SCDF_RELEASE  Skipper: v. $SKIPPER_RELEASE) complete!!"
echo ""
