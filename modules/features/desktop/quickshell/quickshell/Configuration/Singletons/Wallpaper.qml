pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property bool loopEnabled

  function random() {
    Quickshell.execDetached(["sh", "-c", "$NIXOS_SCRIPTS_DIR/wallpaper/RandomWallpaper.sh"])
  }

  function toggleLoop() {
    Quickshell.execDetached(["sh", "-c", "$NIXOS_SCRIPTS_DIR/wallpaper/ToggleWallpaperLoop.sh"])
    loopEnabled = !loopEnabled
  }

  function picker() {
    Quickshell.execDetached(["sh", "-c", "$NIXOS_SCRIPTS_DIR/wallpaper/WallpaperPicker.sh"])
  }

  Process {
    id: proc_is_loop_active
    command: [ "cat", "/tmp/BackgroundLoop.pid" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: data => {
        root.loopEnabled = (this.text.length != 0)
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: {
      proc_is_loop_active.running = true
    }
  }
}
