pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int percentage: 0
  property real value: 0

  Process {
    id: proc_usage
    command: [ "sh", "-c", "top -bn1 | awk '/Cpu/ { print $2 }'"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {

        root.value = parseFloat(this.text)
        root.percentage = parseInt(root.value)
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
