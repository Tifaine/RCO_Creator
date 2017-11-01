#include "gestionservo.h"

GestionServo::GestionServo(QObject *parent)
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


void GestionServo::listFichierServo()
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
            listServo.append(new Servo);
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

void GestionServo::mustDelete()
{
    listServo.clear();
}

int GestionServo::getNbServo()
{
    return listServo.size();
}

QString GestionServo::getNomServo(int indice)
{
    return listServo.at(indice)->getNom();
}

int GestionServo::getIdServo(int indiceServo)
{
    return listServo.at(indiceServo)->getId();
}

int GestionServo::getNbAction(int indiceServo)
{
    return listServo.at(indiceServo)->listNom.size();
}

QString GestionServo::getNomAction(int indiceServo, int indiceAction)
{
    return listServo.at(indiceServo)->listNom.at(indiceAction);
}

int GestionServo::getValAction(int indiceServo, int indiceAction)
{
    return listServo.at(indiceServo)->listValue.at(indiceAction);
}
