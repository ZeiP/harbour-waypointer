import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: savePage

    SilicaFlickable {
        anchors.fill: parent
        Column {
            anchors.fill: parent
            DialogHeader {
                acceptText: qsTr("Save")
            }
            TextField {
                id: nameField
                width: parent.width
                label: qsTr("Route name")
                placeholderText: qsTr("Route name")
                focus: true

                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: savePage.accept()
            }
        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            waypoints.saveWaypoints(nameField.text);
        }
    }
}
