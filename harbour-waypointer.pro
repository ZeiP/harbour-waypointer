# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-waypointer

CONFIG += sailfishapp

SOURCES += src/harbour-waypointer.cpp \
    src/waypoints.cpp

DISTFILES += qml/harbour-waypointer.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-waypointer.changes.in \
    rpm/harbour-waypointer.changes.run.in \
    rpm/harbour-waypointer.spec \
    rpm/harbour-waypointer.yaml \
    translations/*.ts \
    harbour-waypointer.desktop \
    qml/pages/SettingsPage.qml \
    qml/pages/LoggingPage.qml \
    qml/pages/SavePage.qml \
    qml/pages/CustomNotePage.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

QT += positioning

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-waypointer-fi.ts

HEADERS += \
    src/waypoints.h
