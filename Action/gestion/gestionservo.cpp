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
    TiXmlDocument doc("servo.xml");
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
        if(elemName == "Servo")
        {
            listServo.append(new Servo);
            for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
            {
                std::string elemBisName = elemBis->Value();
                if(elemBisName == "nom")
                {
                    listServo.last()->setNom(elemBis->GetText());
                }else if(elemBisName == "id")
                {
                    QString id = elemBis->GetText();
                    listServo.last()->setId(id.toInt());
                }else if(elemBisName == "NomVal")
                {
                    listServo.last()->listNom.append(elemBis->GetText());
                }else if(elemBisName == "val")
                {
                    QString val = elemBis->GetText();
                    listServo.last()->listValue.append(val.toInt());
                }
            }
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
