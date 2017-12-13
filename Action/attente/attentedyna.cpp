#include "attentedyna.h"

AttenteDyna::AttenteDyna()
{

}

void AttenteDyna::saveXML(QXmlStreamWriter *xmlWriter)
{
    xmlWriter->writeStartElement("actionRetourDyna");
    xmlWriter->writeTextElement("nomDyna",getNomDyna());
    xmlWriter->writeTextElement("idDyna",QString::number(getIdDyna(),'f',0));
    xmlWriter->writeTextElement("retourAngle",QString::number(getValueDyna(),'f',0));
    xmlWriter->writeEndElement();
}

void AttenteDyna::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionRetourDyna");
        break;
    case 2:
        break;
    }
}

int AttenteDyna::getIdDyna() const
{
    return idDyna;
}

void AttenteDyna::setIdDyna(int value)
{
    idDyna = value;
}

int AttenteDyna::getValueDyna() const
{
    return valueDyna;
}

void AttenteDyna::setValueDyna(int value)
{
    valueDyna = value;
}

QString AttenteDyna::getNomDyna() const
{
    return nomDyna;
}

void AttenteDyna::setNomDyna(const QString &value)
{
    nomDyna = value;
}
