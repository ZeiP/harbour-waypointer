import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: qsTr("Save")
                onClicked: pageStack.push(Qt.resolvedUrl("SavePage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Waypointer")
            }
            ButtonLayout {
                Button {
                    text: qsTr("Custom text")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("CustomNotePage.qml"), {coordinate: positionSource.position.coordinate})
                    }
                }
                Button {
                    text: qsTr("Cancel last")
                    onClicked: {
                        lastLog = waypoints.removeLastWaypoint();
                    }
                }

                Repeater {
                    model: rootTexts;
                    Component.onCompleted: {
                        rootTexts.updateValues();
                    }

                    Button {
                        text: model.text
                        width: parent.width
                        onClicked: {
                            lastLog = waypoints.addWaypoint(this.text, positionSource.position.coordinate);
                        }
                    }
                }
            }

            Label {
                id: lastLogLabel
                x: Theme.horizontalPageMargin
                text: mainWindow.lastLog
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeMedium
            }
        }
    }
}
