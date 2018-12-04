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
    TiXmlDocument doc("dyna.xml");
    if(!doc.LoadFile())
    {

    }
    TiXmlElement* root = doc.FirstChildElement();
    std::string elemNameRoot = root->Value();
    if(elemNameRoot == "typeXml")
    {

    }
    root = root->NextSiblingElement();

    for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
    {

        std::string elemName = elem->Value();
        if(elemName == "Dyna")
        {
            listDyna.append(new Dynamixel);
            for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
            {
                std::string elemBisName = elemBis->Value();
                if(elemBisName == "nom")
                {
                    listDyna.last()->setNom(elemBis->GetText());
                }else if(elemBisName == "id")
                {
                    QString id = elemBis->GetText();
                    listDyna.last()->setId(id.toInt());
                }else if(elemBisName == "NomVal")
                {
                    listDyna.last()->listNom.append(elemBis->GetText());
                }else if(elemBisName == "val")
                {
                    QString val = elemBis->GetText();
                    listDyna.last()->listValue.append(val.toInt());
                }else if(elemBisName == "nomVitesse")
                {
                    listDyna.last()->listNomVitesse.append(elemBis->GetText());
                }else if(elemBisName == "vitesse")
                {
                    QString vitesse = elemBis->GetText();
                    listDyna.last()->listValueVitesse.append(vitesse.toInt());
                }
            }
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
