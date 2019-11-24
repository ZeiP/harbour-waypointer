// #ifdef QT_QML_DEBUG
#include <QtQuick>
// #endif

#include <sailfishapp.h>
#include "waypoints.h"
#define APP_VERSION "0.5.5"

int main(int argc, char *argv[])
{
    // Set up QML engine.
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> v(SailfishApp::createView());

    // If you wish to publish your app on the Jolla harbour, it is recommended
    // that you prefix your internal namespaces with "harbour.".
    //
    // For details see:
    // https://harbour.jolla.com/faq#1.5.0
    qmlRegisterType<Waypoints>("harbour.waypointer", 1, 0, "Waypoints");

    Waypoints *waypoints = new Waypoints();
    v->rootContext()->setContextProperty("waypoints", waypoints);
    v->rootContext()->setContextProperty("appName", "WayPointer");
    v->rootContext()->setContextProperty("appVersion", APP_VERSION);

    // Start the application.
    v->setSource(SailfishApp::pathTo("qml/harbour-waypointer.qml"));
    v->show();
    return app->exec();
}
