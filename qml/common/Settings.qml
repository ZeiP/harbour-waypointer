import QtQuick 2.0
import Nemo.Configuration 1.0

ConfigurationGroup {
    id: waypointer

    path: "/apps/harbour-waypointer"

    property string presets
    property bool noConfirmCancel
    property int horizontalAccuracyLimit
    property bool autoIncrementNames : true
}
