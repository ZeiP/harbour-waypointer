import QtQuick 2.0
import Nemo.Configuration 1.0

ConfigurationGroup {
    id: waypointer

    path: "/apps/harbour-waypointer"

    property string values
    property bool noConfirmCancel
    property int horizontalAccuracyLimit
}
