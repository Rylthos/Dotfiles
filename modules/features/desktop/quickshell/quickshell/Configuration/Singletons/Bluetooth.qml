pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property bool active
  property bool connected

  function toggle() {
    if (active) {
      disable()
    } else {
      enable()
    }
  }

  function enable() {
    Quickshell.execDetached(["bluetoothctl", "power", "on"])
    active = true
  }

  function disable() {
    Quickshell.execDetached(["bluetoothctl", "power", "off"])
    active = false
    connected = false
  }

  function openContext() {
    Quickshell.execDetached(["blueman-manager"])
  }

  Process {
    id: proc_is_active
    command: [ "sh", "-c", "echo show | bluetoothctl | grep 'Powered' | awk '{print $2}'" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: data => {
        root.active = (this.text === "yes\n")
      }
    }
  }

  Process {
    id: proc_is_connected
    command: [ "sh", "-c", "echo info | bluetoothctl | grep '\\sPaired:' | awk '{print $2}'" ]
    running: false

    stdout: StdioCollector {
      onStreamFinished: data => {
        root.connected = (this.text === "yes\n")
      }
    }
  }

  Timer {
    interval: 1000
    running: root.active
    repeat: true
    onTriggered: {
      proc_is_connected.running = true
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: {
      proc_is_active.running = true
    }
  }
}
