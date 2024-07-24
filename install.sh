##########################################################################################
#
# Magisk Module Installer Script
#
##########################################################################################

SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false

##########################################################################################
# Replace list
##########################################################################################

# Construct your own list here
REPLACE=""

##########################################################################################
# Function Callbacks
##########################################################################################

print_modname() {
  ui_print " "
  ui_print "*******************************"
  ui_print "        Infamick Script        "
  ui_print "            v1.0               "
  ui_print "*******************************"
  ui_print " "
  ui_print "Supported OS: Android with root"
  ui_print "Supported Root: Magisk/KernelSU/APatch"
  ui_print " "
  ui_print "*******************************"
  ui_print " "
}

show_changelog() {
  ui_print "Changelog for v1.0:"
  ui_print "- Initial release of Infamick script"
  ui_print "- Boot count reset functionality"
  ui_print "- Temperature monitoring feature"
  ui_print "- Battery health check"
  ui_print "- Color-coded output for better readability"
  ui_print " "
}

on_install() {
  ui_print "[+] Installing Infamick Script..."
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  
  # Move the infamick script to the correct location
  mkdir -p $MODPATH/system/bin
  mv $MODPATH/infamick $MODPATH/system/bin/infamick
  
  ui_print "[-] Cleaning package cache..."
  rm -rf /data/system/package_cache/*
  
  ui_print " "
  ui_print "Installation completed!"
  ui_print "Use 'infamick' command to run the script."
  ui_print " "
  
  show_changelog
  
  ui_print "Enjoy!"
  sleep 2
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  
  # Set specific permissions for the infamick script
  set_perm $MODPATH/system/bin/infamick 0 0 0755
}

##########################################################################################
# Custom Functions
##########################################################################################

# You can add more functions to assist your custom script code