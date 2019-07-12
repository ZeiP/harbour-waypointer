import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: cancelConfirmPage

    SilicaFlickable {
        anchors.fill: parent
        DialogHeader {
            acceptText: qsTr("Remove last waypoint")
        }
        Label {
            id: label
            anchors.centerIn: parent
            width: parent.width*0.9
            wrapMode: Text.WordWrap
            text: qsTr("Do you really want to remove the last waypoint %1?").arg(waypoints.getLastlog());
        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            lastLog = waypoints.removeLastWaypoint();
        }
    }
}
