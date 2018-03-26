#include "gestionmqtt.h"

gestionMQTT::gestionMQTT()
{

}

void gestionMQTT::upload()
{

    QFile fichierXML("/tmp/temp.xml");
    if(!fichierXML.exists())
    {
        qDebug()<<"Fichier temp non trouvé.";
    }else
    {
        fichierXML.open(QIODevice::ReadOnly);
        QString s;

        QTextStream s1(&fichierXML);
        s.append(s1.readAll());

        client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.77"),1883);
        //client = new QMqttClient(QString("RCO_Creator"),QHostAddress("172.16.130.37"),1883);
        client->connect();

        client->publish(QString("eave/setXmlScenario/robot0/"),s.toLocal8Bit());

        QThread::msleep(50);
        client->publish(QString("eave/setInfos/robot0/"),"SET_ACTION_STATUS 3");
        client->disconnect();
    }
}


void gestionMQTT::play()
{
    client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.135"),1883);
    client->connect();

    client->publish(QString("eave/setInfos/robot0/"),"SET_ACTION_STATUS 0");

    client->disconnect();
}

void gestionMQTT::pause()
{
    client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.135"),1883);
    client->connect();

    client->publish(QString("eave/setInfos/robot0/"),"SET_ACTION_STATUS 1");

    client->disconnect();
}

void gestionMQTT::stop()
{
    client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.135"),1883);
    client->connect();

    client->publish(QString("eave/setInfos/robot0/"),"SET_ACTION_STATUS 2");

    client->disconnect();
}
