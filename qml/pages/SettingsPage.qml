import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: settingspage

    SilicaFlickable {
        anchors.fill: parent
        VerticalScrollDecorator {}
        Column {
            anchors.fill: parent
            DialogHeader {
                acceptText: qsTr("Save")
            }
            Label {
                text: "Minimum horizontal accuracy"
                anchors.horizontalCenter: parent.horizontalCenter
                color: palette.highlightColor
                font.family: Theme.fontFamilyHeading
            }

            Slider {
                id: horizontalAccuracyLimitField
                width: parent.width
                minimumValue: 0
                maximumValue: 100
                value: settings.horizontalAccuracyLimit
                stepSize: 1
                valueText: (value == 0 ? qsTr("Disabled") : value + " m")
                label: qsTr("Minimum horizontal accuracy to enable capture")
            }
            TextSwitch {
                id: noConfirmCancel
                checked: settings.noConfirmCancel
                text: qsTr("Don't confirm before cancel")
                description: qsTr("If selected, no confirmation will be shown before the last waypoint is removed with the cancel button")
            }
            SectionHeader {
                text: "Preset Buttons"
            }
            TextArea {
                id: presetsField
                width: parent.width
                label: qsTr("One button per line. \nN++ will auto-increment eg Tree-1++")
                labelVisible: true
                placeholderText: qsTr("One per line.\n The buttons are usually best aligned with an even number of presets.")
                text: settings.presets

            }
            TextSwitch {
                id: autoIncrementNames
                checked: settings.autoIncrementNames
                text: qsTr("AutoIncrement Names")
                description: qsTr("A Button with N++ will increment each time it is pressed")
            }

        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            settings.presets = presetsField.text;
            settings.noConfirmCancel = noConfirmCancel.checked;
            settings.horizontalAccuracyLimit = horizontalAccuracyLimitField.value
            settings.autoIncrementNames = autoIncrementNames.checked
            rootTexts.updateValues();
        }
    }
}
