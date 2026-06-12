import QtQuick
import QtQuick.Layouts

import Nix
import "../../Widgets" as Widgets
import "../../Widgets/Defaults" as WidgetDefaults
import "../../Config/" as Config
import "../../Singletons/" as Singletons

Rectangle {
  id: info_layout

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

    columns: 4
    columnSpacing: Config.Spacing.gap
    rowSpacing: Config.Spacing.gap

    property real cellSize: (width - (this.columns - 1) * columnSpacing - Config.Spacing.margin) / this.columns

    WidgetDefaults.UsageCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: ""
      units: "GiB"
      percentage: Singletons.MemoryUsage.percentage
      value: Singletons.MemoryUsage.value
      colour: Colourscheme.teal
    }

    WidgetDefaults.UsageCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: ""
      percentage: Singletons.CPUUsage.percentage
      value: Singletons.CPUUsage.value
      units: "%"
      colour: Colourscheme.yellow
    }

    WidgetDefaults.UsageCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: ""
      units: "°C"
      percentage: (Singletons.Temperature.value / 80.) * 100
      value: Singletons.Temperature.value
      colour: Colourscheme.red
    }

    WidgetDefaults.UsageCell {
      Layout.preferredWidth: parent.cellSize
      Layout.preferredHeight: parent.cellSize

      icon: ""
      percentage: Singletons.DiskUsage.percentage
      value: Singletons.DiskUsage.value.toFixed(1)
      units: "GB"
      colour: Colourscheme.blue
    }
  }
}
