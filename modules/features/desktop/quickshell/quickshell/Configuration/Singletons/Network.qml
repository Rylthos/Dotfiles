pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property real upload: 0
  property real download: 0
  property string upload_units: "B/s"
  property string download_units: "B/s"

  function openContext() {
    Quickshell.execDetached(["nm-connection-editor"])
  }

  Process {
    id: proc_network
    command: [ "sh", "-c", "awk '{if(l1){print $2-l1,$10-l2} else{l1=$2; l2=$10;}}' <(grep wlp2s0 /proc/net/dev) <(sleep 1; grep wlp2s0 /proc/net/dev)"]

    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        var data = this.text.split(" ").map(i => parseInt(i))

        var convert = (value) => {
          if (value > 1000 * 1000) {
            return [value / (1000 * 1000), "MB/s"]
          } else if (value > 1000) {
            return [value / 1000, "KB/s"]
          } else {
            return [value, "B/s"]
          }
        }

        var upload = convert(data[0])
        root.upload = upload[0].toFixed(1)
        root.upload_units = upload[1]

        var download = convert(data[1])
        root.download = download[0].toFixed(1)
        root.download_units = download[1]
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      proc_network.running = true
    }
  }
}
