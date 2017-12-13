#include "actionmoteur.h"

ActionMoteur::ActionMoteur()
{
    setType(typeMoteur);
}

void ActionMoteur::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionDeplacement");

    xmlWriter->writeEndElement();
}


void ActionMoteur::saveXML(TiXmlElement * root, int indice)
{

}
