PR = "r1"

FILES_${PN} += "${libdir}/weston/* ${sysconfdir}/xdg"
FILES_${PN}-dbg += "${libdir}/weston/.debug/*"

do_install_append() {
    WESTON_INI_CONFIG=${sysconfdir}/xdg/weston
    install -d ${D}${WESTON_INI_CONFIG}
    install -m 0644 ${S}/ivi-shell/weston.ini.in ${D}${WESTON_INI_CONFIG}/weston.ini
    sed -i -e 's/hmi-controller.so/hmi-controller.so,ivi-controller.so/' \
          -e 's|\@libexecdir\@|${libexecdir}|' \
          -e 's|\@plugin_prefix\@||' \
          -e 's|\@abs_top_srcdir\@\/data|${datadir}\/weston|' \
          -e 's|\@abs_top_builddir\@\/clients|${bindir}|' \
          -e 's|\@abs_top_builddir\@\/weston-ivi-shell-user-interface|${libdir}/weston/weston-ivi-shell-user-interface|' \
          ${D}${WESTON_INI_CONFIG}/weston.ini
    sed -i -e 's|\@abs_top_builddir\@\/weston-|${bindir}/weston-|' \
          ${D}${WESTON_INI_CONFIG}/weston.ini
}
