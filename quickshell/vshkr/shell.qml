//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.modules.bar.workspaces

ShellRoot {
    id: root

    GlobalShortcut {
        name: "atest"
        description: "Just a test"
        onPressed: {
            console.log("well, yeah")
        }
    }

    PanelWindow {
        id: bar

        anchors.top: true
        anchors.left: true
        anchors.right: true

        implicitHeight: 38
        color: "#111111"

        RowLayout {
            id: workspaceContainer

            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Repeater {
                model: 10

                Rectangle {
                    id: workspaceSlot

                    required property int index

                    width: 12
                    height: 12
                    radius: width / 2
                    color: isActive() ? "#4a90e2" : "#555555"

                    function isActive() {
                        return (index + 1) === Hyprland.focusedWorkspace?.id
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Hyprland.dispatch(`workspace ${parent.index + 1}`)
                        }
                    }
                }
            }
        }
    }
}
