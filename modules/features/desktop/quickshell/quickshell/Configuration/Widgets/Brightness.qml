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
    var brightness = Singletons.Brightness.brightness

    var icon = Singletons.Brightness.getIcon()

    return icon + " " + String(brightness).padStart(3, ' ') + "%"
  }
}
