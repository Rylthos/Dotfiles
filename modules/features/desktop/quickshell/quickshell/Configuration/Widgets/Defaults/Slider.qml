import QtQuick
import QtQuick.Layouts

import "../Singletons" as Singletons
import "../Config" as Config
import Nix

Rectangle {
  id: root
  required property string text;
  required property int percentage;

  property color colour: Colourscheme.text

  implicitHeight: 30

  color: "transparent"

  RowLayout {
    anchors.fill: parent

    Rectangle {
      Layout.fillHeight: true
      Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

      color: "transparent"

      implicitWidth: 30

      Text {
        anchors.verticalCenter: parent.verticalCenter

        text: root.text
        color: colour

        font.family: Config.Font.family;
        font.pointSize: 28;
      }
    }

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      radius: 15
      anchors.margins: Config.Spacing.margin

      color: Colourscheme.surface0

      Rectangle {
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }

        implicitWidth: parent.width * (root.percentage / 100.)
        radius: parent.radius

        color: colour
      }
    }
  }
}
