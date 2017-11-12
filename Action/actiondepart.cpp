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
