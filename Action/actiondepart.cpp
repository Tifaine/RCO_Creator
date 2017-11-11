#include "actiondepart.h"

ActionDepart::ActionDepart()
{
    setType(typeEntree);
}

void ActionDepart::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionDépart");
    xmlWriter->writeTextElement("Lets"," Go");
    xmlWriter->writeEndElement();
}
