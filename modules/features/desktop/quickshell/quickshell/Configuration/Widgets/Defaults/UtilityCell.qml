import QtQuick
import QtQuick.Layouts

import "../../Config" as Config
import Nix

Rectangle {
  id: root
  required property string icon;
  property bool isActive: false

  signal leftClick
  signal rightClick
  signal middleClick

  radius: 10 - Config.Spacing.margin / 2

  readonly property color activeColour: Colourscheme.blue

  color: {
    if (root.isActive)  {
      if (mouse.containsMouse) {
        return Qt.lighter(activeColour, 1.1)
      } else {
        return activeColour
      }
    } else {
      if (mouse.containsMouse) {
        return Colourscheme.surface2
      } else {
        return Colourscheme.surface1
      }
    }

    return colour
  }

  Text {
    anchors.centerIn: parent
    text: icon

    color: Colourscheme.text
    font.family: Config.Font.family
    font.pointSize: Config.Font.pointSize * 2
  }

  MouseArea {
    id: mouse
    anchors.fill: parent

    propagateComposedEvents: true
    hoverEnabled: true

    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

    onClicked: (mouse) => {
      if (mouse.button == Qt.LeftButton) {
        leftClick()
        mouse.accepted = true
      } else if (mouse.button == Qt.MiddleButton) {
        middleClick()
        mouse.accepted = true
      } else if (mouse.button == Qt.RightButton) {
        rightClick()
        mouse.accepted = true
      }
    }
  }
}
