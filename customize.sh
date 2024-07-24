#!/data/adb/magisk/busybox sh
set -o standalone

set -x
# Check root environment
VER=`grep_prop version $MODPATH/module.prop`
VERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print "  ID: $MODID"
ui_print "  Version: $VER"
ui_print "  VersionCode: $VERCODE"
if [ "$KSU" == true ]; then
ui_print "  KSUVersion: $KSU_VER"
ui_print "  KSUVersionCode: $KSU_VER_CODE"
ui_print "  KSUKernelVersionCode: $KSU_KERNEL_VER_CODE"
else
ui_print "  MagiskVersion: $MAGISK_VER"
ui_print "  MagiskVersionCode: $MAGISK_VER_CODE"
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

# Show changelog
show_changelog() {
  ui_print " "
  ui_print "Changelog for Infamick Script v1.0:"
  ui_print "- Initial release of Infamick script"
  ui_print "- Boot count reset functionality"
  ui_print "- Temperature monitoring feature"
  ui_print "- Battery health check"
  ui_print "- Color-coded output for better readability"
  ui_print " "
}

# Final adjustment
ADDON && FINALIZE

# Display changelog
show_changelog

ui_print "Installation completed!"
ui_print "Use 'infamick' command to run the script."
ui_print " "
ui_print "Enjoy!"