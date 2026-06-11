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

  implicitWidth: 500
  implicitHeight: 700

  color: "transparent"

  Rectangle {
    anchors.fill: parent

    color: Colourscheme.base

    radius: 15

    ColumnLayout {
      anchors.fill: parent

      spacing: Config.Spacing.gap

      Rectangle {
        color: "transparent"

        Layout.alignment: Qt.AlignTop | Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.margins: Config.Spacing.margin

        implicitHeight: columns.implicitHeight

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

      ColumnLayout {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.margins: Config.Spacing.margin

        WidgetDefaults.Slider {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true

            colour: Colourscheme.blue

            text: Singletons.Volume.getIcon()
            percentage: Singletons.Volume.volumeCapped
        }

        WidgetDefaults.Slider {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true

            visible: Singletons.Brightness.exists

            text: Singletons.Brightness.getIcon()
            percentage: Singletons.Brightness.brightness
        }
      }

      Grid {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.margins: Config.Spacing.margin

        columns: 3
      }
    }
  }

  MouseArea {
    id: mouse
    anchors.fill: parent

    hoverEnabled: true

    onClicked: State.ControlCenter.toggleLock()
    onExited: State.ControlCenter.close()
    onEntered: State.ControlCenter.open()
  }
}
