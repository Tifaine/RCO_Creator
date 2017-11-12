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
