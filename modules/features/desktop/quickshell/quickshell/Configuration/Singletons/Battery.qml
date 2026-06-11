pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property bool charging: false
  property bool exists: false
  property int charge: 0

  Process {
    id: proc_exists
    command: [ "cat", "/sys/class/power_supply/BAT0/present" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.exists = (this.text == "1")
    }
  }

  Process {
    id: proc_capacity
    command: [ "cat", "/sys/class/power_supply/BAT0/capacity" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: { root.charge = this.text }
    }
  }

  Process {
    id: proc_charging
    command: [ "cat", "/sys/class/power_supply/BAT0/status" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.charging = (this.text === "Charging\n")
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      proc_capacity.running = true
      proc_charging.running = true
    }
  }
}
