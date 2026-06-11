pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int brightness: 0
  property bool exists: true

  function getIcon() {
    var brightness = root.brightness
    var icons = [ "", "", "", "", "", "", "", "", "" ]

    var index = Math.trunc((brightness / 100.) * (icons.length - 1))
    return icons[index]
  }

  Process {
    id: proc_udev_brightness
    command: [ "udevadm", "monitor", "--subsystem-match=backlight" ]
    running: true

    stdout: SplitParser {
      onRead: data => {
        proc_brightness.running = true
      }
    }
  }

  Process {
    id: proc_brightness
    command: [ "brightnessctl", "-m" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.brightness = parseInt(this.text.split(",")[3])
    }
  }
}
