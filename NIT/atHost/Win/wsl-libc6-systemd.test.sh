# Restart init.  Currently handles chroots, systemd and upstart, and
# assumes anything else is going to not fail at behaving like
# sysvinit:
TELINIT=yes
if ischroot 2>/dev/null; then
    # Don't bother trying to re-exec init from a chroot:
    TELINIT=no
elif [ -n "${DPKG_ROOT:-}" ]; then
    # Do not re-exec init if we are operating on a chroot from outside:
    TELINIT=no
elif [ -d /run/systemd/system ]; then
    # Restart systemd on upgrade, but carefully.
    # The restart is wanted because of LP: #1942276 and Bug: #993821
    # The care is needed because of https://bugs.debian.org/753725
    # (if systemd --help fails the system might still be quite broken but
    # that seems better than the kernel panic that results if systemd
    # cannot reexec itself).
    TELINIT=no
    if systemd --help >/dev/null 2>/dev/null; then
        systemctl daemon-reexec
    else
        echo "Error: Could not restart systemd, systemd binary not working" >&2
    fi
fi
if [ "$TELINIT" = "yes" ]; then
    telinit u 2>/dev/null || true ; sleep 1
fi