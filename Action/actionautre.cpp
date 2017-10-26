#include "actionautre.h"

ActionAutre::ActionAutre()
{
    setType(typeAutre);
}

void ActionAutre::saveXML(QXmlStreamWriter *xmlWriter)
{
    qDebug()<<"Action autre";
}
