#include "actionmoteur.h"

ActionMoteur::ActionMoteur()
{
    setType(typeMoteur);
}

void ActionMoteur::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionMoteur");
    xmlWriter->writeTextElement("id",QString::number(getIdMoteur(),'f',0));
    xmlWriter->writeTextElement("value",QString::number(getValueMoteur(),'f',0));
    xmlWriter->writeEndElement();
}


void ActionMoteur::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionMoteur");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("id", QString::number(getIdMoteur(),'f',0).toStdString().c_str());
        param->SetAttribute("value", QString::number(getValueMoteur(),'f',0).toStdString().c_str());
        break;
    }
}

int ActionMoteur::getValueMoteur() const
{
    return valueMoteur;
}

void ActionMoteur::setValueMoteur(int value)
{
    valueMoteur = value;
}

int ActionMoteur::getIdMoteur() const
{
    return idMoteur;
}

void ActionMoteur::setIdMoteur(int value)
{
    idMoteur = value;
}
