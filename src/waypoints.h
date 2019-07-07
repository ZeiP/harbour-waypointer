#ifndef WAYPOINTS_H
#define WAYPOINTS_H

#include <QObject>
#include <QGeoCoordinate>
#include <QDateTime>
#include <QVector>

class Waypoints : public QObject
{
    Q_OBJECT
public:
    explicit Waypoints(QObject *parent = nullptr);
    Q_INVOKABLE QString addWaypoint(QString description, QGeoCoordinate pos);
    Q_INVOKABLE bool saveWaypoints(QString name);

signals:
//    void error(const QString& msg);

public slots:

private:
    struct waypoint {
      QString name;
      double lat;
      double lon;
      QDateTime time;
    };
    QVector<waypoint> waypoints;
};

#endif // WAYPOINTS_H
