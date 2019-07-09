import QtQuick 2.0
import Sailfish.Silica 1.0

import QtPositioning 5.2

Dialog {
    id: customNotePage

    property variant coordinate

    SilicaFlickable {
        anchors.fill: parent
        Column {
            anchors.fill: parent
            DialogHeader {
                acceptText: qsTr("Save")
            }
            TextField {
                id: noteField
                width: parent.width
                label: qsTr("Note text")
                placeholderText: qsTr("Note text")
                focus: true

                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: customNotePage.accept()
            }
            ComboBox {
                id: locationSelect
                width: parent.width
                label: qsTr("Location to use")
                description: qsTr("Select if you want to record the waypoint using the location when the button was pressed or the location when you accept this dialog.")

                menu: ContextMenu {
                    MenuItem { text: qsTr("Button") }
                    MenuItem { text: qsTr("Save") }
                }
            }
        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            if (locationSelect.value === qsTr("Save")) {
                coordinate = positionSource.position.coordinate;
            }
            lastLog = waypoints.addWaypoint(noteField.text, coordinate);
        }
    }
}
