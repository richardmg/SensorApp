#include <QtDeclarative>
#include <QtWidgets>
#include <QtSensors>

void sensorError(int error)
{
    qDebug() << "Sensor error:" << error;
}

// Accelerometer ///////////////////////////

class QMLAccelerometer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool active READ isActive WRITE setActive NOTIFY activeChanged)
    Q_PROPERTY(qreal x READ x NOTIFY xChanged)
    Q_PROPERTY(qreal y READ y NOTIFY yChanged)
    Q_PROPERTY(qreal z READ z NOTIFY zChanged)

public:
    QMLAccelerometer() : m_x(0), m_y(0), m_z(0)
    {
        connect(&m_sensor, &QAccelerometer::sensorError, &sensorError);
        connect(&m_sensor, &QAccelerometer::readingChanged, this, &QMLAccelerometer::readingChanged);
    }

    bool isActive()
    {
        return m_sensor.isActive();
    }

    void setActive(bool active)
    {
        if (active == m_sensor.isActive())
            return;
        if (active)
            m_sensor.start();
        else
            m_sensor.stop();
        emit activeChanged();
    }

    qreal x() const { return m_x; };
    qreal y() const { return m_y; };
    qreal z() const { return m_z; };

signals:
    void activeChanged();
    void xChanged();
    void yChanged();
    void zChanged();

private slots:
    void readingChanged()
    {
        QAccelerometerReading *r = m_sensor.reading();
        m_x = r->x();
        m_y = r->y();
        m_z = r->z();
        emit xChanged();
        emit yChanged();
        emit zChanged();
    }

private:
    QAccelerometer m_sensor;
    qreal m_x;
    qreal m_y;
    qreal m_z;
};

// Gyroscope ///////////////////////////

class QMLGyroscope : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool active READ isActive WRITE setActive NOTIFY activeChanged)
    Q_PROPERTY(qreal x READ x NOTIFY xChanged)
    Q_PROPERTY(qreal y READ y NOTIFY yChanged)
    Q_PROPERTY(qreal z READ z NOTIFY zChanged)

public:
    QMLGyroscope() : m_x(0), m_y(0), m_z(0)
    {
        connect(&m_sensor, &QGyroscope::sensorError, &sensorError);
        connect(&m_sensor, &QGyroscope::readingChanged, this, &QMLGyroscope::readingChanged);
    }

    bool isActive()
    {
        return m_sensor.isActive();
    }

    void setActive(bool active)
    {
        if (active == m_sensor.isActive())
            return;
        if (active)
            m_sensor.start();
        else
            m_sensor.stop();
        emit activeChanged();
    }

    qreal x() const { return m_x; };
    qreal y() const { return m_y; };
    qreal z() const { return m_z; };

signals:
    void activeChanged();
    void xChanged();
    void yChanged();
    void zChanged();

    private slots:
    void readingChanged()
    {
        QGyroscopeReading *r = m_sensor.reading();
        m_x = r->x();
        m_y = r->y();
        m_z = r->z();
        emit xChanged();
        emit yChanged();
        emit zChanged();
    }

private:
    QGyroscope m_sensor;
    qreal m_x;
    qreal m_y;
    qreal m_z;
};

#include "main.moc"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    app.primaryScreen()->setOrientationUpdateMask(Qt::PortraitOrientation);
    
    qmlRegisterType<QMLAccelerometer,1>("Sensors", 1, 0, "Accelerometer");
    qmlRegisterType<QMLAccelerometer,1>("Sensors", 1, 0, "Gyroscope");

    QDeclarativeView view;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    
    view.setSource(QUrl("qrc:/main.qml"));
    view.setViewportUpdateMode(QDeclarativeView::FullViewportUpdate);
    view.show();

    return app.exec();
}


