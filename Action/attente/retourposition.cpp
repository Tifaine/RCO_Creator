#include "retourposition.h"

RetourPosition::RetourPosition()
{
    setType(typeRetourPosition);
}

int RetourPosition::getXRobot() const
{
    return xRobot;
}

void RetourPosition::setXRobot(int value)
{
    xRobot = value;
}

int RetourPosition::getYRobot() const
{
    return yRobot;
}

void RetourPosition::setYRobot(int value)
{
    yRobot = value;
}

int RetourPosition::getPrecision() const
{
    return precision;
}

void RetourPosition::setPrecision(int value)
{
    precision = value;
}

void RetourPosition::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionRetourPosition");
    xmlWriter->writeTextElement("coordX",QString::number(xRobot,'f',0));
    xmlWriter->writeTextElement("coordY",QString::number(yRobot,'f',0));
    xmlWriter->writeTextElement("precision",QString::number(precision,'f',0));
    xmlWriter->writeEndElement();
}

void RetourPosition::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionRetourPosition");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("x", QString::number(xRobot,'f',0).toStdString().c_str());
        param->SetAttribute("y", QString::number(yRobot,'f',0).toStdString().c_str());
        param->SetAttribute("precision", QString::number(precision,'f',0).toStdString().c_str());
        break;
    }
}
