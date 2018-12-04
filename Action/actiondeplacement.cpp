#include "actiondeplacement.h"

ActionDeplacement::ActionDeplacement()
{

}

int ActionDeplacement::getIdValeur() const
{
    return idValeur;
}

void ActionDeplacement::setIdValeur(int value)
{
    idValeur = value;
}

int ActionDeplacement::getValueValeur() const
{
    return valueValeur;
}

void ActionDeplacement::setValueValeur(int value)
{
    valueValeur = value;
}

int ActionDeplacement::getVitesse() const
{
    return vitesse;
}

void ActionDeplacement::setVitesse(int value)
{
    vitesse = value;
}

void ActionDeplacement::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionDeplacement");
    xmlWriter->writeTextElement("id",QString::number(getIdValeur(),'f',0));
    xmlWriter->writeTextElement("value",QString::number(getValueValeur(),'f',0));
    xmlWriter->writeTextElement("vitesse",QString::number(getVitesse(),'f',0));
    xmlWriter->writeEndElement();
}

void ActionDeplacement::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionDeplacement");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("id", QString::number(getIdValeur(),'f',0).toStdString().c_str());
        param->SetAttribute("value", QString::number(getValueValeur(),'f',0).toStdString().c_str());
        param->SetAttribute("vitesse", QString::number(getVitesse(),'f',0).toStdString().c_str());
        break;
    }
}
