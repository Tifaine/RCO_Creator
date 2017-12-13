#include "actiondepart.h"

ActionDepart::ActionDepart()
{
    setType(typeEntree);
}

void ActionDepart::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionDepart");
    xmlWriter->writeTextElement("Lets"," Go");
    xmlWriter->writeEndElement();
}

void ActionDepart::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionDepart");
        break;
    case 2:
        break;
    }
}
