
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    property string gitRepo : "ZeiP/harbour-waypointer"
    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("About")// "+appName)
            }
            Image {
                id: icon
                source: "/usr/share/icons/hicolor/128x128/apps/harbour-waypointer.png"
                anchors.horizontalCenter: parent.horizontalCenter
            }
// Appname and AppVersion are set in harbour-waypointer.cpp
            Text {
                text: appName + " v" + appVersion
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "(c) Jyri-Petteri Paloposki ZeiP 2019"
                width: parent.width
            }
            Label {
                text: qsTr("Released under GPLv3")
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                text: "" //qsTr('Please ')
                    + '<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=XXXX">'
                    + qsTr('Please Donate')+'</a>'+qsTr(' if you like this application')
                   // + '<p>'

                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }

            SectionHeader {
                text: "Github"
            }
            Button {
                //% "View source on Github"
                text: qsTr("View Source")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: Qt.openUrlExternally("https://github.com/"+gitRepo)
            }
            Button {
                //% "Report Issue"
                text: qsTr("Report Issue")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: Qt.openUrlExternally("https://github.com/"+gitRepo+"/issues")
            }


            SectionHeader {
                text: qsTr("Translate")
            }
            Label {
                text: qsTr('Translations can be done in ')
                      +'<a href="https://www.transifex.com/'+gitRepo+'">Transifex</a>'
                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall

                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
//            Label {
//                text: qsTr("Translations")
//                width: parent.width
//                font.underline: true
//            }

            Label {
                text: '<ul>'
                    + '<li>Finnish, Francais - Jyri-Petteri Paloposki </li>'
                    + '</ul>'
                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
            }

        }
    }
}


