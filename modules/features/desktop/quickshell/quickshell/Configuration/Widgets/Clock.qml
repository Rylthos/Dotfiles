import QtQuick

import "../Singletons" as Singletons
import "../Config" as Config
import Nix

Text {
  text: Singletons.Time.time

  font.family: Config.Font.family
  font.pointSize: Config.Font.pointSize

  color: Colourscheme.text
}
