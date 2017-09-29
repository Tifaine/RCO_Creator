#include "gestionservo.h"
#include <QtXml>

gestionServo::gestionServo(QObject *parent) : QObject(parent)
{
    fichierServo = new QFile("servo.xml");
    if(fichierServo->exists())
    {
        listFichierServo();
    }
    watcher = new QFileSystemWatcher();
    watcher->addPath("servo.xml");
    connect(watcher,SIGNAL(fileChanged(QString)),this,SLOT(listFichierServo()));
}

void gestionServo::listFichierServo()
{
    listServo.clear();
    fichierServo->open(QIODevice::ReadOnly);
    QXmlStreamReader xmlReader(fichierServo);
    xmlReader.readNextStartElement();
    while(!xmlReader.atEnd())
    {
        xmlReader.readNextStartElement();
        if(xmlReader.name().compare((QString)"Servo")==0)
        {

        }
        if(xmlReader.name().compare((QString)"nom")==0)
        {
            listServo.append(new servo);
            listServo.last()->setNom(xmlReader.readElementText());
        }
        if(xmlReader.name().compare((QString)"id")==0)
        {
            listServo.last()->setId(xmlReader.readElementText().toInt());
        }
        if(xmlReader.name().compare((QString)"NomVal")==0)
        {

            listServo.last()->ajouterValeur("",0);
            listServo.last()->listNom.append(xmlReader.readElementText());
        }
        if(xmlReader.name().compare((QString)"val")==0)
        {
            listServo.last()->listValue.append(xmlReader.readElementText().toInt());
        }
    }

}

void gestionServo::mustDelete()
{
     listServo.clear();
}

int gestionServo::getNbServo()
{
    return listServo.size();
}

QString gestionServo::getNomServo(int indice)
{
    return listServo.at(indice)->getNom();
}

int gestionServo::getNbAction(int indiceServo)
{
    return listServo.at(indiceServo)->listNom.size();
}

QString gestionServo::getNomAction(int indiceServo, int indiceAction)
{
    return listServo.at(indiceServo)->listNom.at(indiceAction);
}

int gestionServo::getIdAction(int indiceServo, int indiceAction)
{
    return listServo.at(indiceServo)->listValue.at(indiceAction);
}
