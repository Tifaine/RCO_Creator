#include "actionmoteur.h"

ActionMoteur::ActionMoteur()
{
    setType(typeMoteur);
}

void ActionMoteur::saveXML(QXmlStreamWriter* xmlWriter)
{
qDebug()<<"Action moteur";
}

