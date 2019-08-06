import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: settingspage

    SilicaFlickable {
        anchors.fill: parent
        Column {
            anchors.fill: parent
            DialogHeader {
                acceptText: qsTr("Save")
            }
            Slider {
                id: horizontalAccuracyLimitField
                width: parent.width
                minimumValue: 0
                maximumValue: 100
                value: settings.horizontalAccuracyLimit
                stepSize: 1
                valueText: (value == 0 ? qsTr("Disabled") : value + " m")
                label: qsTr("Minimum horizontal accuracy")
            }
            TextSwitch {
                id: noConfirmCancel
                checked: settings.noConfirmCancel
                text: qsTr("Don't confirm before cancel")
                description: qsTr("If selected, no confirmation will be shown before the last waypoint is removed with the cancel button")
            }
            TextArea {
                id: valueField
                width: parent.width
                label: qsTr("Preset texts one per line")
                placeholderText: qsTr("Preset texts one per line. The buttons are usually best aligned with an even number of presets.")
                text: settings.values
            }
        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            settings.values = valueField.text;
            settings.noConfirmCancel = noConfirmCancel.checked;
            settings.horizontalAccuracyLimit = horizontalAccuracyLimitField.value
            rootTexts.updateValues();
        }
    }
}
