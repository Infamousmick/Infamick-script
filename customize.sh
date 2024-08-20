#!/data/adb/magisk/busybox sh
set -o standalone

set -x
# Check root environment
VER=`grep_prop version $MODPATH/module.prop`
VERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print "  ID: $MODID"
ui_print "  Version: $VER"
ui_print "  VersionCode: $VERCODE"
if [ "$KSU" = "true" ]; then
ui_print "  KernelSUVersion=$KSU_KERNEL_VER_CODE (kernel) + $KSU_VER_CODE (ksud)" 
elif [ "$APATCH" = "true" ]; then
APATCH_VER=$(cat "/data/adb/ap/version")
ui_print "  APatchVersion=$APATCH_VER" 
else
ui_print "  Magisk=Installed" 
ui_print "  suVersion=$(su -v)" 
ui_print "  MagiskVersion=$(magisk -v)" 
ui_print "  MagiskVersionCode=$(magisk -V)" 
fi
ui_print " "

# Check Android API
[ $API -ge 23 ] ||
 abort "- Unsupported API version: $API"

# Patch the XML and place the modified one to the original directory
{
NULL="/dev/null"
}

# Additional add-on for check gms status
ADDON() {
 ui_print "- Installing Infamick script"
mkdir -p $MODPATH/system/bin
mv -f $MODPATH/infamick $MODPATH/system/bin/infamick
}

FINALIZE() {
 ui_print "- Finalizing installation"

# Clean up
 ui_print "  Cleaning obsolete files"
find $MODPATH/* -maxdepth 0 \
! -name 'module.prop' \
! -name 'post-fs-data.sh' \
! -name 'service.sh' \
! -name 'system' \
-exec rm -rf {} \;

# Settings dir and file permission
 ui_print "  Settings permissions"
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm $MODPATH/system/bin/infamick 0 2000 0755
}

# Final adjustment
ADDON && FINALIZE

ui_print "Installation completed!"
ui_print "Use 'infamick' command to run the script."
ui_print " "
ui_print "Enjoy!"
