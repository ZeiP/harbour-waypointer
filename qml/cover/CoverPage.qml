import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    anchors.fill: parent

    Column {
        anchors.centerIn: parent
        Image {
            id: icon
            source: "image://theme/harbour-waypointer"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Waypointer")
        }
    }

    CoverActionList {
        id: coverActions

        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                if (locationValid()) {
                    pageStack.push(Qt.resolvedUrl("../pages/CustomNotePage.qml"), {coordinate: positionSource.position.coordinate});
                }
                mainWindow.activate();
            }
        }
    }
}
