pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property bool active

  function toggle() {
    Quickshell.execDetached(["sh", "-c", "$NIXOS_SCRIPTS_DIR/ToggleScreenReplay.sh"])
    active = !active
  }

  function save() {
    Quickshell.execDetached(["sh", "-c", "$NIXOS_SCRIPTS_DIR/screenRecorder/save_replay.sh"])
  }

  Process {
    id: proc_is_active
    command: [ "sh", "-c", "ps -ef | grep gpu-screen-recorder | grep /nix/store" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: data => {
        active = (this.text.split("\n").length > 2)
      }
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
