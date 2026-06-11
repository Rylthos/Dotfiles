pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int percentage: 0
  property real value: 0
  property real max: 0

  Process {
    id: proc_usage
    command: [ "sh", "-c", "df -k | awk '{print $6,$5,$4,$3}'" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        var items = this.text.split("\n").map(l => l.split(" ")).filter(e => e[0] === "/")[0]

        root.percentage = parseInt(items[1])
        root.value = parseInt(items[2]) / (1024 * 1024)
        root.max = parseInt(items[3]) / (1024 * 1024)
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
