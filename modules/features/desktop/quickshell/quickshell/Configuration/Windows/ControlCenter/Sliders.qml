import QtQuick
import QtQuick.Layouts

import Nix
import "../../Widgets" as Widgets
import "../../Widgets/Defaults" as WidgetDefaults
import "../../Config/" as Config
import "../../Singletons/" as Singletons

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
