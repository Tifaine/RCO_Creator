#include "attentetemps.h"

AttenteTemps::AttenteTemps()
{
    setType(typeAttenteTemps);
}

int AttenteTemps::getTemps() const
{
    return temps;
}

void AttenteTemps::setTemps(int value)
{
    temps = value;
}

void AttenteTemps::saveXML(QXmlStreamWriter *xmlWriter)
{
    xmlWriter->writeStartElement("actionPause");
    xmlWriter->writeTextElement("valueAttente",QString::number(getTemps(),'f',0));
    xmlWriter->writeEndElement();
}
