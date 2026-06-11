
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
    command: [ "sh", "-c", "free -m | awk '/Mem/{print $2; print $3}'" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        var items = this.text.split("\n")

        var total = items[0]
        var avail = items[1]

        root.percentage = ((total - avail) / total) * 100
        root.value = ((total-avail) / (1024.)).toFixed(2)
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
