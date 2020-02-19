#!/bin/sh
FOLDER="$(realpath "$(dirname "$0")")"
if [ -e $FOLDER/env.sh ]; then
	chmod 777 $FOLDER/env.sh
	. $FOLDER/env.sh
else
	. /opt/spring-cloud-space/temp/env.sh
fi
if [ ! -e $OUTFOLDER ]; then
	echo "Cannot continue install download folder doesn't exists!!"
	echo "Folder: $OUTFOLDER"
    exit 1
fi
ls $OUTFOLDER
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
echo "Installing server packages for Spring Cloud Data Flow Infrastructure (Dataflow: v. $SCDF_RELEASE  Skipper: v. $SKIPPER_RELEASE)"
echo ""
echo "Installing executables for Spring Cloud Data Flow Server v. $SCDF_RELEASE"
mv $OUTFOLDER/spring-cloud-dataflow-server-$SCDF_RELEASE.jar $DFS_FOLDER/spring-cloud-dataflow-server.jar
echo "$SCDF_RELEASE" > $DFS_FOLDER/version
echo ""
echo "Installing executables for Spring Cloud Data Flow shell v. $SCDF_RELEASE"
mv $OUTFOLDER/spring-cloud-dataflow-shell-$SCDF_RELEASE.jar $DFH_FOLDER/spring-cloud-dataflow-shell.jar
echo "$SCDF_RELEASE" > $DFH_FOLDER/version
echo ""
echo "Installing executables for Spring Cloud Skipper Server v. $SKIPPER_RELEASE"
mv $OUTFOLDER/spring-cloud-skipper-server-$SKIPPER_RELEASE.jar $SKS_FOLDER/spring-cloud-skipper-server.jar
echo "$SKIPPER_RELEASE" > $SKS_FOLDER/version
echo "Installing executables for Spring Cloud Skipper Shell v. $SKIPPER_RELEASE"
echo ""
mv $OUTFOLDER/spring-cloud-skipper-shell-$SKIPPER_RELEASE.jar $SKH_FOLDER/spring-cloud-skipper-shell.jar
echo "$SKIPPER_RELEASE" > $SKH_FOLDER/version
echo "Installation of Spring Cloud Data Flow Infrastructure (Dataflow: v. $SCDF_RELEASE  Skipper: v. $SKIPPER_RELEASE) complete!!"
echo ""
