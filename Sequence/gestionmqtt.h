#ifndef GESTIONMQTT_H
#define GESTIONMQTT_H
#include <QObject>
#include <QFile>
#include <QDebug>
#include <QTextStream>
#include <QIODevice>
#include "../MQTT/QMqttClient.h"
#include <QThread>

class gestionMQTT : public QObject
{
    Q_OBJECT
public:
    gestionMQTT();

public slots:
    void upload();
    void play();
    void uploadBlack();
    void playBlack();
    void pause();
    void stop();
private:

};

#endif // GESTIONMQTT_H
