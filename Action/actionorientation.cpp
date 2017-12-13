#include "actionorientation.h"

ActionOrientation::ActionOrientation()
{
    setType(typeOrientation);
}

void ActionOrientation::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionRotation");
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


void ActionOrientation::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionRotation");
        break;
    case 2:
        break;
    }
}
