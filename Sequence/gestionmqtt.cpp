#include "gestionmqtt.h"

gestionMQTT::gestionMQTT()
{
    client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.229"),1883);
    //client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.77"),1883);
    client->connect();
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



        //client->publish(QString("eave/setXmlScenario/robot0/"),s.toLocal8Bit());
        system("mosquitto_pub -h 192.168.43.229 -t eave/setXmlScenario/robot0/ -f /tmp/temp.xml");
        QThread::msleep(50);
        system("mosquitto_pub -h 192.168.43.229 -t eave/setInfos/robot0/ -m \"SET_ACTION_STATUS 3\"");
        //->publish(QString("eave/setInfos/robot0/"),"SET_ACTION_STATUS 3");
        //client->disconnect();
    }
}


void gestionMQTT::play()
{
    // client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.229"),1883);
    //client->connect();

    //client->publish(QString("eave/setInfos/robot0/"),"SET_ACTION_STATUS 0");

    // client->disconnect();
    system("mosquitto_pub -h 192.168.43.229 -t eave/setInfos/robot0/ -m \"SET_ACTION_STATUS 0\"");
}

void gestionMQTT::pause()
{
    //    client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.229"),1883);
    //    client->connect();

    //    client->publish(QString("eave/setInfos/robot0/"),"SET_ACTION_STATUS 1");

    //    client->disconnect();

    system("mosquitto_pub -h 192.168.43.229 -t eave/setInfos/robot0/ -m \"SET_ACTION_STATUS 1\"");
}

void gestionMQTT::stop()
{
    //    client = new QMqttClient(QString("RCO_Creator"),QHostAddress("192.168.43.229"),1883);
    //    client->connect();

    //    client->publish(QString("eave/setInfos/robot0/"),"SET_ARU");

    //    client->disconnect();
    system("mosquitto_pub -h 192.168.43.229 -t eave/setInfos/robot0/ -m \"SET_ARU\"");
}
