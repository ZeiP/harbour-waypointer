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
            TextArea {
                id: valueField
                width: parent.width
                label: qsTr("Preset texts one per line")
                placeholderText: qsTr("Preset texts one per line. The buttons are usually best aligned with an even number of presets.")
                text: settings.values
            }
            TextSwitch {
                id: noConfirmCancel
                checked: settings.noConfirmCancel
                text: qsTr("Don't confirm before cancel")
                description: qsTr("If selected, no confirmation will be shown before the last waypoint is removed with the cancel button")
            }
        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            settings.values = valueField.text;
            settings.noConfirmCancel = noConfirmCancel.checked;
            rootTexts.updateValues();
        }
    }
}
