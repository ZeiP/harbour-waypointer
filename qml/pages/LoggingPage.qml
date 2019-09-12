import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    property bool lastEnabledStatus: false;

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

            Timer {
                interval: 2000
                running: true
                repeat: true
                onTriggered: {
                    if (locationValid()) {
                        if (lastEnabledStatus == false) {
                            btnCustomText.enabled = true;
                            btnRepeater.setStatuses(true);
                            lastEnabledStatus = true;
                        }
                    }
                    else {
                        if (lastEnabledStatus == true) {
                            btnCustomText.enabled = false;
                            btnRepeater.setStatuses(false);
                            lastEnabledStatus = false;
                        }
                    }
                }
            }

            PageHeader {
                title: qsTr("Waypointer")
            }

            ButtonLayout {
                Button {
                    id: btnCustomText
                    text: qsTr("Custom text")
                    enabled: false
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("CustomNotePage.qml"), {coordinate: positionSource.position.coordinate})
                    }
                }
                Button {
                    text: qsTr("Cancel last")
                    onClicked: {
                        console.log(settings.noConfirmCancel);
                        if (!settings.noConfirmCancel) {
                            pageStack.push(Qt.resolvedUrl("CancelConfirmation.qml"));
                        }
                        else {
                            lastLog = waypoints.removeLastWaypoint();
                        }
                    }
                }

                Repeater {
                    id: btnRepeater
                    model: rootTexts

                    Button {
                        text: model.text
                        width: parent.width
                        onClicked: {
                            lastLog = waypoints.addWaypoint(this.text, positionSource.position.coordinate);
                        }
                    }

                    Component.onCompleted: {
                        rootTexts.updateValues();
                        setStatuses(false);
                    }

                    onItemAdded: {
                        setStatuses(lastEnabledStatus);
                    }

                    function setStatuses(status) {
                        for (var i = 0; i < btnRepeater.count; i++) {
                            var button = btnRepeater.itemAt(i);
                            button.enabled = status;
                        }
                    }
                }
            }

            Row {
                x: Theme.horizontalPageMargin
                spacing: 20

                Label {
                    id: lastLogLabel
                    text: mainWindow.lastLog
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeMedium
                }
                Label {
                    id: locationAccuracyLabel
                    text: mainWindow.locationAccuracyText
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeSmall
                }
            }
        }
    }
}
