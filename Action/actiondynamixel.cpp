#include "actiondynamixel.h"

ActionDynamixel::ActionDynamixel()
{
    setType(typeDyna);
}

void ActionDynamixel::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionDyna");
    xmlWriter->writeTextElement("nomDyna",getNomDyna());
    xmlWriter->writeTextElement("idDyna",QString::number(getIdDyna(),'f',0));
    xmlWriter->writeTextElement("angle",QString::number(getValueDyna(),'f',0));
    xmlWriter->writeTextElement("vitesse",QString::number(getVitesseDyna(),'f',0));
    xmlWriter->writeEndElement();
}

void ActionDynamixel::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionDyna");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("nom", getNomDyna().toStdString().c_str());
        param->SetAttribute("id", QString::number(getIdDyna(),'f',0).toStdString().c_str());
        param->SetAttribute("angle", QString::number(getValueDyna(),'f',0).toStdString().c_str());
        param->SetAttribute("vitesse", QString::number(getVitesseDyna(),'f',0).toStdString().c_str());
        break;
    }
}

int ActionDynamixel::getIdDyna() const
{
    return idDyna;
}

void ActionDynamixel::setIdDyna(int value)
{
    idDyna = value;
}

int ActionDynamixel::getValueDyna() const
{
    return valueDyna;
}

void ActionDynamixel::setValueDyna(int value)
{
    valueDyna = value;
}

int ActionDynamixel::getVitesseDyna() const
{
    return vitesseDyna;
}

void ActionDynamixel::setVitesseDyna(int value)
{
    vitesseDyna = value;
}

QString ActionDynamixel::getNomDyna() const
{
    return nomDyna;
}

void ActionDynamixel::setNomDyna(const QString &value)
{
    nomDyna = value;
}
