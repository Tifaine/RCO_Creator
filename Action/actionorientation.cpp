#include "actionorientation.h"

ActionOrientation::ActionOrientation()
{
    setType(typeOrientation);
}

void ActionOrientation::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionRotation");
    xmlWriter->writeTextElement("angle",QString::number(angle,'f',0));
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

int ActionOrientation::getPrecision() const
{
    return precision;
}

void ActionOrientation::setPrecision(int value)
{
    precision = value;
}

int ActionOrientation::getVitesse() const
{
    return vitesse;
}

void ActionOrientation::setVitesse(int value)
{
    vitesse = value;
}


void ActionOrientation::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionRotation");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("angle", QString::number(angle,'f',0).toStdString().c_str());
        param->SetAttribute("vitesse", QString::number(vitesse,'f',0).toStdString().c_str());
        param->SetAttribute("precision", QString::number(precision,'f',0).toStdString().c_str());
        break;
    }
}
