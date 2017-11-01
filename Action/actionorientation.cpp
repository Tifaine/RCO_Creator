#include "actionorientation.h"

ActionOrientation::ActionOrientation()
{
    setType(typeOrientation);
}

void ActionOrientation::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionOrientation");
    xmlWriter->writeTextElement("orientation",QString::number(angle,'f',0));
    xmlWriter->writeEndElement();
}

int ActionOrientation::getAngle() const
{
    return angle;
}

void ActionOrientation::setAngle(int value)
{
    angle = value;
}

