import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    property bool lastEnabledStatus: false;

    function updateIDString(button,MatchAtEndOnly) {
      var iN=button.text.search(/\d+\+\+$/); //match NNN++ at end first
      if (!(iN>0) && (!MatchAtEndOnly)) {
          iN=button.text.search(/\d+\+\+/); //match NNN++ elsewhere if not at end
        };
      if (iN>0) { //if match that needs incrementing then...
            var str=button.text;
            var S=str.slice(iN,str.length);
            var iN2= S.search(/\+\+/); //in2 is end of number
            S = S.slice(0,S.search(/\+\+/)); //just number
            var N=parseInt(S)+1;
            button.text = str.slice(0,iN)+N+str.slice(iN+iN2);
            return str.slice(0,iN)+N+str.slice(iN+iN2+2);
          //and update the list??
        } else {
            return button.text;
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

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
            }
                SectionHeader {
                    text: "Presets"
                }
                ButtonLayout {

                Repeater {
                    id: btnRepeater
                    model: rootTexts

                    Button {
                        text: model.text.length===0 ? "<new preset>" : model.text
                        width: parent.width

                        onClicked: {
                            if (text === "<new preset>") {
                              pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
                            } else {

                            var PointName=updateIDString(this,false);
                            lastLog = waypoints.addWaypoint(PointName, positionSource.position.coordinate);
                            }
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
                SectionHeader {
                    text: "Last Waypoint"
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
