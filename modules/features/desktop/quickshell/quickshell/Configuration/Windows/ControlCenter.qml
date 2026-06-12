import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Nix

import "../State" as State
import "../Config" as Config
import "../Singletons/" as Singletons
import "../Widgets/" as Widgets
import "../Widgets/Defaults" as WidgetDefaults

import "ControlCenter" as ControlCenter

PanelWindow {
  visible: State.ControlCenter.isOpen

  anchors.top: true
  exclusionMode: ExclusionMode.Ignore

  implicitWidth: 450
  implicitHeight: contents.implicitHeight + Config.Spacing.margin * 2

  IdleInhibitor {
    id: idleInhibitor
    window: parent
    enabled: false
  }

  margins {
    top: 5
  }

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

        ControlCenter.Sliders { }

        ControlCenter.InfoWidgets { }

        ControlCenter.UtilityWidgets {
          idleInhibitor: idleInhibitor
        }
      }
    }
  }
}
