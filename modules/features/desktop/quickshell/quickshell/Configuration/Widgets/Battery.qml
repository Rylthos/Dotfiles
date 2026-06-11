import QtQuick

import "../Singletons" as Singletons
import "../Config" as Config
import Nix

Text {
  text: getText()

  font.family: Config.Font.family
  font.pointSize: Config.Font.pointSize

  color: Singletons.Battery.charging ? Colourscheme.red : Colourscheme.green

  function getIcon(charge, charging) {
    var draining_icons = [ "󰁺 ", "󰁻 ", "󰁼 ", "󰁽 ", "󰁾 ", "󰁿 ", "󰂀 ", "󰂁 ", "󰂂 ", "󰁹 " ]
    var charging_icons = [ "󰢜 ", "󰂆 ", "󰂇 ", "󰂈 ", "󰢝 ", "󰂉 ", "󰢞 ", "󰂊 ", "󰂋 ", "󰂅 " ]

    var icons = charging ? charging_icons : draining_icons

    var index = Math.trunc((charge / 100.) * icons.length)
    return icons[index]
  }

  function getText() {
    var charge = Singletons.Battery.charge
    var charging = Singletons.Battery.charging

    var icon = getIcon(charge, charging)

    return String(charge).padStart(3, ' ') + "% " + icon
  }
}
