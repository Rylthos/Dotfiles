import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import "../../Config" as Config
import Nix

Rectangle {
  required property string icon;
  required property int percentage;
  required property real value;
  required property string units;
  required property color colour;

  color: Colourscheme.surface1

  radius: 10 - Config.Spacing.margin / 2

  RowLayout {
    anchors.fill: parent
    anchors.margins: Config.Spacing.margin / 2

    spacing: Config.Spacing.gap

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.preferredWidth: 1

      Layout.horizontalStretchFactor: 1

      color: "transparent"

      Text {
        anchors.centerIn: parent

        text: icon

        color: colour
        font.family: Config.Font.family
        font.pointSize: Config.Font.pointSize * 1.5
      }
    }

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.preferredWidth: 1

      Layout.horizontalStretchFactor: 2

      color: Colourscheme.surface2
      radius: 10

      Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        implicitHeight: parent.height * 0.8

        color: "transparent"

        Shape {
          id: shape
          anchors.fill: parent

          property int strokeWidth: 8
          property real r: width / 2 - strokeWidth / 2 - Config.Spacing.gap
          property real cx: width / 2
          property real cy: height / 2

          ShapePath {
            strokeWidth: shape.strokeWidth
            strokeColor: Colourscheme.mantle
            capStyle: ShapePath.RoundCap
            startX: 0
            startY: 0
            fillColor: "transparent"
            PathAngleArc {
              centerX: shape.cx
              centerY: shape.cy
              radiusX: shape.r
              radiusY: radiusX
              startAngle: -45
              sweepAngle: 270
            }
          }

          ShapePath {
            strokeWidth: 8
            strokeColor: colour
            capStyle: ShapePath.RoundCap
            startX: 0
            startY: 0
            fillColor: "transparent"
            PathAngleArc {
              centerX: shape.cx
              centerY: shape.cy
              radiusX: shape.r
              radiusY: radiusX
              startAngle: -45
              sweepAngle: (Math.min(percentage, 100) / 100) * 270
            }
          }

          Text {
            anchors.centerIn: parent
            text: percentage + "%"

            color: Colourscheme.text

            font.family: Config.Font.family
            font.pointSize: Config.Font.pointSize
          }
        }
      }

      Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        text: value + units

        color: Colourscheme.text

        font.family: Config.Font.family
        font.pointSize: Config.Font.pointSize / 1.5
      }
    }
  }
}
