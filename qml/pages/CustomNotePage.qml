import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: customNotePage

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
        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            lastLog = waypoints.addWaypoint(noteField.text, positionSource.position.coordinate);
        }
    }
}
