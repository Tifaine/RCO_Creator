#include "actionfin.h"

ActionFin::ActionFin()
{
    setType(typeFin);
}

void ActionFin::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionFin");
    xmlWriter->writeTextElement("Itis", "The end");
    xmlWriter->writeEndElement();
}

void ActionFin::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionFin");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("Itis", "The end");
        break;
    }
}
