#include "gestiondyna.h"
#include <QtXml>

gestionDyna::gestionDyna(QObject *parent) : QObject(parent)
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

void gestionDyna::listFichierDyna()
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
            listDyna.append(new dynamixel);
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

void gestionDyna::mustDelete()
{
    listDyna.clear();
}

int gestionDyna::getNbDyna()
{
   return listDyna.size();
}

QString gestionDyna::getNomDyna(int indice)
{
    return listDyna.at(indice)->getNom();
}

int gestionDyna::getNbAction(int indiceDyna)
{
    return listDyna.at(indiceDyna)->listNom.size();
}

QString gestionDyna::getNomAction(int indiceDyna, int indiceAction)
{
    return listDyna.at(indiceDyna)->listNom.at(indiceAction);
}

int gestionDyna::getValAction(int indiceDyna, int indiceAction)
{
    return listDyna.at(indiceDyna)->listValue.at(indiceAction);
}

int gestionDyna::getNbVitesse(int indiceDyna)
{
    return listDyna.at(indiceDyna)->listNomVitesse.size();
}

QString gestionDyna::getNomVitesse(int indiceDyna, int indiceVitesse)
{
    return listDyna.at(indiceDyna)->listNomVitesse.at(indiceVitesse);
}

int gestionDyna::getValVitesse(int indiceDyna, int indiceVitesse)
{
    if(indiceVitesse<listDyna.at(indiceDyna)->listValueVitesse.size())
    {
        return listDyna.at(indiceDyna)->listValueVitesse.at(indiceVitesse);
    }else
    {
        return 0;
    }
}
