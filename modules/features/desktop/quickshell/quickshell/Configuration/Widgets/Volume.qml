import QtQuick

import "../Singletons" as Singletons
import "../Config" as Config
import Nix

Text {
  text: getText()

  font.family: Config.Font.family
  font.pointSize: Config.Font.pointSize

  color: Colourscheme.text

  function getText() {
    var volume = Singletons.Volume.volume

    var icon = Singletons.Volume.getIcon(volume)
    if (volume < 0) { volume = 0 }
    return icon + " " + String(volume).padStart(3, ' ') + "%"
  }
}
