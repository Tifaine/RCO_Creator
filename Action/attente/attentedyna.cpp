#include "attentedyna.h"

AttenteDyna::AttenteDyna()
{

}

void AttenteDyna::saveXML(QXmlStreamWriter *xmlWriter)
{
    xmlWriter->writeStartElement("attenteDyna");
    xmlWriter->writeTextElement("nomDyna",getNomDyna());
    xmlWriter->writeTextElement("idDyna",QString::number(getIdDyna(),'f',0));
    xmlWriter->writeTextElement("valueAttente",QString::number(getValueDyna(),'f',0));
    xmlWriter->writeEndElement();
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
