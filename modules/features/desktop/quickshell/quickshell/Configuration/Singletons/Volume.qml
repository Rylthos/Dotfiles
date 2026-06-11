pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.Pipewire

Singleton {
  id: root

  readonly property int volume: {
    Pipewire.defaultAudioSink.audio.muted ? -1 : (Pipewire.defaultAudioSink?.audio.volume ?? 0) * 100
  }

  readonly property int volumeCapped: {
    volume > 100 ? 100 : volume
  }

  function getIcon() {
    var volume = root.volume
    if (volume >= 60) {
      return "󰕾 "
    } else if (volume >= 20) {
      return "󰖀 "
    } else if (volume >= 0) {
      return "󰕿 "
    } else if (volume == -1){
      return "󰖁 "
    }
  }

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio
  }
}
