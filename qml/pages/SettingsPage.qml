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
                focus: true
                label: qsTr("Preset texts one per line")
                placeholderText: qsTr("Preset texts one per line")
                text: settings.values
            }
        }
        VerticalScrollDecorator {}
    }
    onDone: {
        if (result == DialogResult.Accepted) {
            settings.values = valueField.text;
            rootTexts.updateValues();
        }
    }
}
