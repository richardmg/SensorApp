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
        //m_sensor.setDataRate(2);
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
    Q_PROPERTY(quint64 timestamp READ timestamp)
    Q_PROPERTY(qreal x READ x NOTIFY xChanged)
    Q_PROPERTY(qreal y READ y NOTIFY yChanged)
    Q_PROPERTY(qreal z READ z NOTIFY zChanged)

public:
    QMLGyroscope() : m_x(0), m_y(0), m_z(0)
    {
        connect(&m_sensor, &QGyroscope::sensorError, &sensorError);
        connect(&m_sensor, &QGyroscope::readingChanged, this, &QMLGyroscope::readingChanged);
        //m_sensor.setDataRate(10);
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

    quint64 timestamp() const { return m_timestamp; };
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
        m_timestamp = r->timestamp();
        m_x = r->x();
        m_y = r->y();
        m_z = r->z();
        emit xChanged();
        emit yChanged();
        emit zChanged();
    }

private:
    QGyroscope m_sensor;
    quint64 m_timestamp;
    qreal m_x;
    qreal m_y;
    qreal m_z;
};

// Magnetometer ///////////////////////////

class QMLMagnetometer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool active READ isActive WRITE setActive NOTIFY activeChanged)
    Q_PROPERTY(quint64 timestamp READ timestamp)
    Q_PROPERTY(qreal x READ x NOTIFY xChanged)
    Q_PROPERTY(qreal y READ y NOTIFY yChanged)
    Q_PROPERTY(qreal z READ z NOTIFY zChanged)
    Q_PROPERTY(bool returnGeoValues READ returnGeoValues WRITE setReturnGeoValues NOTIFY returnGeoValuesChanged)


public:
    QMLMagnetometer() : m_x(0), m_y(0), m_z(0)
    {
        connect(&m_sensor, &QMagnetometer::sensorError, &sensorError);
        connect(&m_sensor, &QMagnetometer::readingChanged, this, &QMLMagnetometer::readingChanged);
//        m_sensor.setDataRate(10);
    }

    bool returnGeoValues() const
    {
        return m_sensor.returnGeoValues();
    }

    void setReturnGeoValues(bool geo)
    {
        if (geo == returnGeoValues())
            return;
        m_sensor.setReturnGeoValues(geo);
        m_sensor.stop();
        m_sensor.start();
        emit returnGeoValuesChanged(geo);
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

    quint64 timestamp() const { return m_timestamp; };
    qreal x() const { return m_x; };
    qreal y() const { return m_y; };
    qreal z() const { return m_z; };

signals:
    void activeChanged();
    void xChanged();
    void yChanged();
    void zChanged();
    void returnGeoValuesChanged(bool returnGeoValues);

    private slots:
    void readingChanged()
    {
        QMagnetometerReading *r = m_sensor.reading();
        m_timestamp = r->timestamp();
        m_x = r->x();
        m_y = r->y();
        m_z = r->z();
        emit xChanged();
        emit yChanged();
        emit zChanged();
    }

private:
    QMagnetometer m_sensor;
    quint64 m_timestamp;
    qreal m_x;
    qreal m_y;
    qreal m_z;
};

// Compass ///////////////////////////

class QMLCompass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool active READ isActive WRITE setActive NOTIFY activeChanged)
    Q_PROPERTY(quint64 timestamp READ timestamp)
    Q_PROPERTY(qreal azimuth READ azimuth NOTIFY azimuthChanged)
    Q_PROPERTY(qreal calibrationLevel READ calibrationLevel NOTIFY calibrationLevelChanged)

public:
    QMLCompass() : m_azimuth(0), m_calibrationLevel(0)
    {
        connect(&m_sensor, &QCompass::sensorError, &sensorError);
        connect(&m_sensor, &QCompass::readingChanged, this, &QMLCompass::readingChanged);
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

    quint64 timestamp() const { return m_timestamp; };
    qreal azimuth() const { return m_azimuth; };
    qreal calibrationLevel() const { return m_calibrationLevel; };

signals:
    void activeChanged();
    void azimuthChanged();
    void calibrationLevelChanged();

    private slots:
    void readingChanged()
    {
        QCompassReading *r = m_sensor.reading();
        m_timestamp = r->timestamp();
        m_azimuth = r->azimuth();
        m_calibrationLevel = r->calibrationLevel();
        emit azimuthChanged();
        emit calibrationLevelChanged();
    }

private:
    QCompass m_sensor;
    quint64 m_timestamp;
    qreal m_azimuth;
    qreal m_calibrationLevel;
};

// Proximity ///////////////////////////

class QMLProximitySensor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool active READ isActive WRITE setActive NOTIFY activeChanged)
    Q_PROPERTY(quint64 timestamp READ timestamp)
    Q_PROPERTY(qreal close READ close NOTIFY closeChanged)
    Q_PROPERTY(bool available READ isAvailable NOTIFY availableChanged)

public:
    QMLProximitySensor() : m_close(false), m_available(true)
    {
        connect(&m_sensor, &QProximitySensor::sensorError, &sensorError);
        connect(&m_sensor, &QProximitySensor::readingChanged, this, &QMLProximitySensor::readingChanged);
        if (!m_sensor.connectToBackend()) {
            m_available = false;
            qDebug() << "setting available to false";
            emit availableChanged();
        }
    }

    bool isAvailable()
    {
        return m_available;
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

    quint64 timestamp() const { return m_timestamp; };
    qreal close() const { return m_close; };

signals:
    void activeChanged();
    void closeChanged();
    void availableChanged();

    private slots:
    void readingChanged()
    {
        QProximityReading *r = m_sensor.reading();
        m_timestamp = r->timestamp();
        m_close = r->close();
        emit closeChanged();
    }

private:
    QProximitySensor m_sensor;
    quint64 m_timestamp;
    bool m_close;
    bool m_available;
};

#include "main.moc"


int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    app.primaryScreen()->setOrientationUpdateMask(Qt::PortraitOrientation);

    qmlRegisterType<QMLAccelerometer,1>("Sensors", 1, 0, "Accelerometer");
    qmlRegisterType<QMLGyroscope,1>("Sensors", 1, 0, "Gyroscope");
    qmlRegisterType<QMLMagnetometer,1>("Sensors", 1, 0, "Magnetometer");
    qmlRegisterType<QMLCompass,1>("Sensors", 1, 0, "Compass");
    qmlRegisterType<QMLProximitySensor,1>("Sensors", 1, 0, "ProximitySensor");

    QDeclarativeView view;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);

    view.setSource(QUrl("qrc:/main.qml"));
    view.setViewportUpdateMode(QDeclarativeView::FullViewportUpdate);
    view.show();

    return app.exec();
}


