import Quickshell
import QtQuick
import QtQuick.Layouts

import Nix
import "../../Widgets" as Widgets
import "../../Widgets/Defaults" as WidgetDefaults
import "../../Config/" as Config
import "../../Singletons/" as Singletons

Rectangle {
  id: info_layout

  property var idleInhibitor

  Layout.fillWidth: true

  color: Colourscheme.mantle
  radius: 10

  implicitHeight: grid.implicitHeight + Config.Spacing.margin * 2

  GridLayout {
    id: grid

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: Config.Spacing.margin

    columns: 5
    columnSpacing: Config.Spacing.gap
    rowSpacing: Config.Spacing.gap

    property real cellSize: (width - (this.columns - 1) * columnSpacing - Config.Spacing.margin) / this.columns

    WidgetDefaults.UtilityCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: "󰲍"

      isActive: Singletons.Wallpaper.loopEnabled

      onLeftClick: Singletons.Wallpaper.random()
      onRightClick: Singletons.Wallpaper.toggleLoop()
      onMiddleClick: Singletons.Wallpaper.picker()
    }

    WidgetDefaults.UtilityCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: Singletons.Bluetooth.connected ? "󰂱": "󰂯"

      isActive: Singletons.Bluetooth.active
      onLeftClick: Singletons.Bluetooth.toggle()
      onRightClick: Singletons.Bluetooth.openContext()
    }

    WidgetDefaults.UtilityCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      isActive: idleInhibitor.enabled
      icon: ""

      onLeftClick: idleInhibitor.enabled = !idleInhibitor.enabled
    }

    WidgetDefaults.UtilityCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: "󰄀"
      isActive: Singletons.ScreenRecorder.active
      onLeftClick: Singletons.ScreenRecorder.toggle()
      onMiddleClick: Singletons.ScreenRecorder.save()
    }

    WidgetDefaults.UtilityCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: "⏻"
      onLeftClick: Quickshell.execDetached(["sh", "-c", "wlogout -b 4 -s -c 10 -T 400 -L 410 -R 410 -B 400"])
    }
  }
}
