#include "actionsetvaleur.h"

ActionSetValeur::ActionSetValeur()
{

}

int ActionSetValeur::getIdValeur() const
{
    return idValeur;
}

void ActionSetValeur::setIdValeur(int value)
{
    idValeur = value;
}

int ActionSetValeur::getValueValeur() const
{
    return valueValeur;
}

void ActionSetValeur::setValueValeur(int value)
{
    valueValeur = value;
}

void ActionSetValeur::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionSetValeur");
    xmlWriter->writeTextElement("id",QString::number(getIdValeur(),'f',0));
    xmlWriter->writeTextElement("value",QString::number(getValueValeur(),'f',0));
    xmlWriter->writeEndElement();
}

void ActionSetValeur::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionSetValeur");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("id", QString::number(getIdValeur(),'f',0).toStdString().c_str());
        param->SetAttribute("value", QString::number(getValueValeur(),'f',0).toStdString().c_str());
        break;
    }
}
