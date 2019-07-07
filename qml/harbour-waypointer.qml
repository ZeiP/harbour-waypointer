import QtQuick 2.0
import Sailfish.Silica 1.0

import "pages"
import "common"

import QtPositioning 5.2

ApplicationWindow
{
    id: mainWindow

    initialPage: Component { LoggingPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    property string lastLog: qsTr("Nothing logged");

    ListModel {
        id: rootTexts
        function updateValues() {
            var values = settings.values.split("\n");

            rootTexts.clear();
            for(var i = 0; i < values.length; i++) {
                var item = {};
                item.text = values[i];
                rootTexts.append(item);
            }
        }
    }

    Settings {
        id: settings
    }

    PositionSource {
        id: positionSource

        onSourceErrorChanged: {
            if (sourceError == PositionSource.NoError)
                return

            console.log("Source error: " + sourceError)
            activityText.fadeOut = true
            stop()
        }
        Component.onCompleted: {
            positionSource.start();
        }
    }
}
