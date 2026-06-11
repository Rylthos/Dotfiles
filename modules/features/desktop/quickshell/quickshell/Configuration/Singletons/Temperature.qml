pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property real value: 0

  Process {
    id: proc_usage
    command: [ "cat", "/sys/class/thermal/thermal_zone0/temp"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {

        root.value = parseInt(this.text) / 1000
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      proc_usage.running = true
    }
  }
}
