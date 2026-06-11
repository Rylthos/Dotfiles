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

  readonly property bool muted: {
    Pipewire.defaultAudioSink.audio.muted
  }

  function setPercent(percent: real) {
    Pipewire.defaultAudioSink.audio.volume = percent / 100
  }

  function modify(increase: bool) {
    var value = increase ? 0.05 : -0.05

    var newValue = Pipewire.defaultAudioSink.audio.volume + value
    Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1, newValue))
  }

  function toggleMute() {
    Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted
  }

  function openContext() {
    Quickshell.execDetached(["pwvucontrol"])
  }

  function getIcon() {
    var volume = root.volume
    if (volume >= 60) {
      return "󰕾"
    } else if (volume >= 20) {
      return "󰖀"
    } else if (volume >= 0) {
      return "󰕿"
    } else if (volume == -1){
      return "󰖁"
    }
  }

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio
  }
}
