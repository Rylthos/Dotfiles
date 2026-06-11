import Quickshell
import QtQuick
import QtQuick.Layouts
import Nix

import "../State" as State
import "../Config" as Config
import "../Singletons/" as Singletons
import "../Widgets/" as Widgets
import "../Widgets/Defaults" as WidgetDefaults

PanelWindow {
  visible: State.ControlCenter.isOpen

  anchors.top: true
  exclusionMode: ExclusionMode.Ignore

  implicitWidth: 450
  implicitHeight: contents.implicitHeight + Config.Spacing.margin * 2

  color: "transparent"

  MouseArea {
    id: mouse
    anchors.fill: parent

    hoverEnabled: true

    onClicked: {State.ControlCenter.toggleLock(); console.log("Click")}
    onEntered: State.ControlCenter.open()
    onExited: State.ControlCenter.close()

    Rectangle {
      id: contents

      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      implicitHeight: contents_layout.implicitHeight + Config.Spacing.margin * 2

      color: Colourscheme.base

      radius: 10 + Config.Spacing.margin

      ColumnLayout {
        id: contents_layout

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Config.Spacing.margin

        spacing: Config.Spacing.gap * 2

        Rectangle {
          id: date_rect

          color: "transparent"

          Layout.alignment: Qt.AlignTop | Qt.AlignVCenter
          Layout.fillWidth: true
          Layout.preferredHeight: columns.implicitHeight

          ColumnLayout {
            id: columns
            anchors.fill: parent
            Text {
              Layout.alignment: Qt.AlignHCenter

              text: Singletons.Time.time
              color: Colourscheme.text

              font.family: Config.Font.family
              font.pointSize: Config.Font.pointSize * 4
            }

            Text {
              Layout.alignment: Qt.AlignHCenter

              text: Singletons.Time.date
              color: Colourscheme.text

              font.family: Config.Font.family
              font.pointSize: Config.Font.pointSize * 2
            }
          }
        }

        Rectangle {
          Layout.fillWidth: true

          Layout.alignment: Qt.AlignHCenter

          color: Colourscheme.mantle

          radius: 15

          implicitHeight: network.implicitHeight + Config.Spacing.margin * 2

          MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true

            acceptedButtons: Qt.RightButton

            onClicked: (mouse) => {
              if (mouse.button == Qt.RightButton) {
                Singletons.Network.openContext()
                mouse.accepted = true
              }
            }
          }

          RowLayout {
            anchors.fill: parent
            id: network

            anchors.margins: Config.Spacing.margin
            uniformCellSizes: true

            Text {
              Layout.alignment: Qt.AlignHCenter

              color: Colourscheme.peach

              text: " " + String(Singletons.Network.upload).padStart(6, ' ') + Singletons.Network.upload_units

              font.family: Config.Font.family
              font.pointSize: Config.Font.pointSize
            }

            Text {
              Layout.alignment: Qt.AlignHCenter

              color: Colourscheme.peach

              text: " " + String(Singletons.Network.download).padStart(6, ' ') + Singletons.Network.download_units

              font.family: Config.Font.family
              font.pointSize: Config.Font.pointSize
            }
          }
        }

        Rectangle {
          Layout.fillWidth: true
          Layout.fillHeight: true

          Layout.preferredHeight: sliders_layout.implicitHeight + Config.Spacing.margin * 2

          radius: 10
          color: Colourscheme.mantle

          ColumnLayout {
            id: sliders_layout

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            anchors.margins: Config.Spacing.margin
            spacing: Config.Spacing.gap

            WidgetDefaults.Slider {
              Layout.alignment: Qt.AlignHCenter
              Layout.fillWidth: true

              colour: Colourscheme.blue
              enableClick: true

              onClickIcon: Singletons.Volume.toggleMute()
              onOpenContext: Singletons.Volume.openContext()

              disable: Singletons.Volume.volume < 0
              text: Singletons.Volume.getIcon()
              percentage: Singletons.Volume.volumeCapped

              onValueModify: (increase) => { Singletons.Volume.modify(increase) }
              onValueSet: (percent) => { Singletons.Volume.setPercent(percent) }
            }

            WidgetDefaults.Slider {
              Layout.alignment: Qt.AlignHCenter
              Layout.fillWidth: true

              visible: Singletons.Brightness.exists

              text: Singletons.Brightness.getIcon()

              percentage: Singletons.Brightness.brightness
              onValueSet: (percent) => {Singletons.Brightness.setPercent(percent)}
              onValueModify: (increase) => { Singletons.Brightness.modify(increase) }
            }
          }
        }

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
      }
    }
  }
}
