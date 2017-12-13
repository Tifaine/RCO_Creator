#include "retourorientation.h"

RetourOrientation::RetourOrientation()
{

}

int RetourOrientation::getOrientation() const
{
    return orientation;
}

void RetourOrientation::setOrientation(int value)
{
    orientation = value;
}

int RetourOrientation::getPrecision() const
{
    return precision;
}

void RetourOrientation::setPrecision(int value)
{
    precision = value;
}

void RetourOrientation::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionRetourRotation");
    xmlWriter->writeTextElement("rotation",QString::number(orientation,'f',0));
    xmlWriter->writeTextElement("precision",QString::number(precision,'f',0));
    xmlWriter->writeEndElement();
}

void RetourOrientation::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionRetourRotation");
        break;
    case 2:
        break;
    }
}
