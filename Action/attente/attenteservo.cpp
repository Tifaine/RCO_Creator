#include "attenteservo.h"

AttenteServo::AttenteServo()
{
    setType(typeAttenteServo);
}

void AttenteServo::saveXML(QXmlStreamWriter *xmlWriter)
{
    xmlWriter->writeStartElement("attenteServo");
    xmlWriter->writeTextElement("nomServo",getNomServo());
    xmlWriter->writeTextElement("idServo",QString::number(getIdServo(),'f',0));
    xmlWriter->writeTextElement("valueAttente",QString::number(getValueAttente(),'f',0));
    xmlWriter->writeEndElement();
}

int AttenteServo::getIdServo() const
{
    return idServo;
}

void AttenteServo::setIdServo(int value)
{
    idServo = value;
}

int AttenteServo::getValueAttente() const
{
    return valueAttente;
}

void AttenteServo::setValueAttente(int value)
{
    valueAttente = value;
}

QString AttenteServo::getNomServo() const
{
    return nomServo;
}

void AttenteServo::setNomServo(const QString &value)
{
    nomServo = value;
}
