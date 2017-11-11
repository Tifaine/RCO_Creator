#include "gestiondynamixel.h"
#include <QtXml>

GestionDynamixel::GestionDynamixel(QObject *parent) : QObject(parent)
{
    fichierDyna = new QFile("dyna.xml");
    if(fichierDyna->exists())
    {
        listFichierDyna();
    }
    watcher = new QFileSystemWatcher();
    watcher->addPath("dyna.xml");
    connect(watcher,SIGNAL(fileChanged(QString)),this,SLOT(listFichierDyna()));
}

void GestionDynamixel::listFichierDyna()
{
    listDyna.clear();
    fichierDyna->open(QIODevice::ReadOnly);
    QXmlStreamReader xmlReader(fichierDyna);
    xmlReader.readNextStartElement();
    while(!xmlReader.atEnd())
    {
        xmlReader.readNextStartElement();

        if(xmlReader.name().compare((QString)"nom")==0)
        {
            listDyna.append(new Dynamixel);
            listDyna.last()->setNom(xmlReader.readElementText());
        }else
        if(xmlReader.name().compare((QString)"id")==0)
        {
            listDyna.last()->setId(xmlReader.readElementText().toInt());
        }else
        if(xmlReader.name().compare((QString)"NomVal")==0)
        {
            listDyna.last()->listNom.append(xmlReader.readElementText());
        }else
        if(xmlReader.name().compare((QString)"val")==0)
        {
            listDyna.last()->listValue.append(xmlReader.readElementText().toInt());
        }else
        if(xmlReader.name().compare((QString)"nomVitesse")==0)
        {
            listDyna.last()->listNomVitesse.append(xmlReader.readElementText());
        }else
        if(xmlReader.name().compare((QString)"vitesse")==0)
        {
            listDyna.last()->listValueVitesse.append(xmlReader.readElementText().toInt());
        }
    }
}

void GestionDynamixel::mustDelete()
{
    listDyna.clear();
}

int GestionDynamixel::getNbDyna()
{
   return listDyna.size();
}

QString GestionDynamixel::getNomDyna(int indice)
{
    return listDyna.at(indice)->getNom();
}

int GestionDynamixel::getIdDyna(int indice)
{
    return listDyna.at(indice)->getId();
}

int GestionDynamixel::getNbAction(int indiceDyna)
{
    return listDyna.at(indiceDyna)->listNom.size();
}

QString GestionDynamixel::getNomAction(int indiceDyna, int indiceAction)
{
    return listDyna.at(indiceDyna)->listNom.at(indiceAction);
}

int GestionDynamixel::getValAction(int indiceDyna, int indiceAction)
{
    return listDyna.at(indiceDyna)->listValue.at(indiceAction);
}

int GestionDynamixel::getNbVitesse(int indiceDyna)
{
    return listDyna.at(indiceDyna)->listNomVitesse.size();
}

QString GestionDynamixel::getNomVitesse(int indiceDyna, int indiceVitesse)
{
    return listDyna.at(indiceDyna)->listNomVitesse.at(indiceVitesse);
}

int GestionDynamixel::getValVitesse(int indiceDyna, int indiceVitesse)
{
    if(indiceVitesse<listDyna.at(indiceDyna)->listValueVitesse.size())
    {
        return listDyna.at(indiceDyna)->listValueVitesse.at(indiceVitesse);
    }else
    {
        return 0;
    }
}
