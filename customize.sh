set -o standalone
set -x

ui_print "- Installing Infamick script systemless-ly"

# Symlink temporaneo per esecuzione immediata post-flash (senza riavvio)
ln -sf $MODPATH/system/bin/infamick /data/local/tmp/infamick
chmod 0755 /data/local/tmp/infamick
ui_print "  -> You can run it immediately via: /data/local/tmp/infamick"

ui_print "- Finalizing installation & applying surgical permissions"

# Pulizia di tutto ciò che non serve all'engine root (modulo più pulito)
find $MODPATH/* -maxdepth 0 \
! -name 'module.prop' \
! -name 'post-fs-data.sh' \
! -name 'service.sh' \
! -name 'system' \
-exec rm -rf {} \;

# KSU/APatch/Magisk Fix: Bonifica CRLF e applicazione permessi nativi
sed -i 's/\r$//' $MODPATH/system/bin/infamick

chown -R 0:0 $MODPATH/system
chmod -R 0755 $MODPATH/system

chown 0:2000 $MODPATH/system/bin/infamick
chmod 0755 $MODPATH/system/bin/infamick

ui_print "- Installation completed! Reboot to apply OverlayFS."