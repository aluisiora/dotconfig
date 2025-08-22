import QtQuick

Component {
    required property var modelData

    RowLayout {
        spacing: 6
        Repeater {
            model: modelData.clients
            delegate: Icon {
                icon: modelData.initialClass
                // Use font.pixelSize for sizing icons instead of CSS.
                font.pixelSize: 18
                color: "#d8dee9" // Explicitly set icon color
            }
        }
    }
}
