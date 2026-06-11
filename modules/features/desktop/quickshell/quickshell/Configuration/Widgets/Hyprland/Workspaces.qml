import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "../../Config" as Config
import Nix

RowLayout {
  required property ShellScreen screen

  anchors.margins: Config.Spacing.margin

  spacing: 0

  Repeater {
    model: 10
    Rectangle {
      id: bg

      implicitWidth: text.implicitWidth + Config.Spacing.margin
      implicitHeight: text.implicitHeight + Config.Spacing.margin

      color: mouse.containsMouse ? Colourscheme.surface1 : Colourscheme.base
      radius: 5

      Behavior on color {
        ColorAnimation {
          duration: Config.Animation.duration
        }
      }

      Text {
        id: text

        property int windowID: Hyprland.monitors.values.find(m => m.name == screen.name).id

        property int workspaceID: 10 * windowID + index + 1

        property var ws: Hyprland.workspaces.values.find(w => w.id == workspaceID)
        property bool isActive: Hyprland.focusedWorkspace?.id == workspaceID

        anchors.centerIn: parent

        text: String(workspaceID).padStart(2, '0')

        color: isActive ? Colourscheme.blue : (ws ? Colourscheme.surface2 : Colourscheme.surface0)

        font {
          family: Config.Font.family
          pointSize: Config.Font.pointSize
        }

        MouseArea {
          id: mouse
          anchors.fill: parent
          onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + text.workspaceID + "})")

          hoverEnabled: true
        }
      }
    }
  }

  Item {
    Layout.fillWidth: true
  }
}
