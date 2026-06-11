pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property bool isOpen: true

  property bool isLocked: false

  function toggle() { if (!isLocked) isOpen = !isOpen }
  function close() { if (!isLocked) isOpen = false }
  function open() { if (!isLocked) isOpen = true }
  function set(open: bool) { if (!isLocked) isOpen = open}

  function toggleLock() { isLocked = !isLocked }
}
