import Quickshell
import Quickshell.Widgets
// import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "../Widgets" as Widgets
import "../Widgets/Hyprland" as Hyprland
import "../Config" as Config
import "../Windows" as Windows
import "../State" as State
import Nix

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData
      screen: modelData

      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: 30

      Rectangle {
        id: clock_bg

        color: Colourscheme.base

        radius: 15

        anchors.centerIn: parent

        implicitWidth: clock.implicitWidth + Config.Spacing.margin * 2
        implicitHeight: 30

        Widgets.Clock {
          id: clock
          anchors.centerIn: parent

          MouseArea {
            id: clockClick
            anchors.fill: parent

            onClicked: {
              State.ControlCenter.toggle()
            }
          }
        }
      }

      Rectangle {
        id: workspace_bg

        color: Colourscheme.base

        radius: 15

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: Config.Spacing.margin

        implicitWidth: workspaces.implicitWidth + Config.Spacing.margin * 2
        implicitHeight: 30

        Hyprland.Workspaces {
          id: workspaces
          screen: bar.screen
          anchors.centerIn: parent
        }
      }

      Rectangle {
        id: info_bg

        color: Colourscheme.base

        radius: 15

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: Config.Spacing.margin

        implicitWidth: {
          icons.implicitWidth + Config.Spacing.margin * 2
        }
        implicitHeight: 30

        RowLayout {
          id: icons

          spacing: Config.Spacing.gap

          anchors.centerIn: parent

          Widgets.Volume {
            id: volume

            color: Colourscheme.blue
          }

          Widgets.Battery {
            id: battery

            visible: Singleton.Battery.exists
          }

          Widgets.Brightness {
            id: brightness

            visible: Singleton.Brightness.exists
          }

          Item {
            Layout.fillWidth: true
          }
        }
      }
    }
  }
}
