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

void AttenteTemps::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionPause");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("temps", QString::number(getTemps(),'f',0).toStdString().c_str());
        break;
    }
}
