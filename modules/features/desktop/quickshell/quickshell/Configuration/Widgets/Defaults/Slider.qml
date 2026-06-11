import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../../Singletons" as Singletons
import "../../Config" as Config
import Nix

Rectangle {
  id: root
  required property string text
  required property int percentage
  property bool disable: false

  property bool enableClick: false

  signal valueModify(increase: bool)
  signal valueSet(percentage: real)
  signal openContext
  signal clickIcon

  property color colour: Colourscheme.text

  implicitHeight: 30

  color: "transparent"

  RowLayout {
    anchors.fill: parent

    Rectangle {
      Layout.fillHeight: true
      Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

      color: (mouse.containsMouse && enableClick) ? Colourscheme.surface1 : "transparent"

      implicitWidth: 30
      radius: 5

      Behavior on color {
        ColorAnimation { duration: Config.Animation.duration }
      }

      Text {
        anchors.centerIn: parent

        text: root.text
        color: colour

        font.family: Config.Font.family;
        font.pointSize: 20;
      }

      MouseArea {
        id: mouse
        anchors.fill: parent

        propagateComposedEvents: true
        hoverEnabled: true

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: (mouse) => {
          if (!root.enableClick) return

          if (mouse.button == Qt.LeftButton) {
            clickIcon()
            mouse.accepted = true
          } else if (mouse.button == Qt.RightButton) {
            openContext()
            mouse.accepted = true
          }
        }
      }
    }

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 15
      anchors.margins: Config.Spacing.margin

      color: Colourscheme.surface1

      Rectangle {
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }

        visible: !root.disable
        radius: parent.radius
        implicitWidth: (radius * 2) + (parent.width - (radius * 2)) * (root.percentage / 100.)

        color: colour
      }

      MouseArea {
        anchors.fill: parent

        propagateComposedEvents: true

        onPressed: (mouse) => { updatePosition(mouse) }
        onClicked: (mouse) => { mouse.accepted = true }
        onPositionChanged: (mouse) => { updatePosition(mouse) }
        onWheel: (wheel) => {
          valueModify(wheel.angleDelta.y > 0)
        }

        function updatePosition(mouse) {
          var percent = Math.round(((mouse.x - parent.radius / 2) / (this.width - parent.radius)) * 100)
          percent = Math.max(0, Math.min(100, percent))

          if (percent != this.percent)
            valueSet(percent)
        }
      }
    }
  }
}
