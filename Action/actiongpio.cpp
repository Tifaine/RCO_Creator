#include "actiongpio.h"

ActionGPIO::ActionGPIO()
{
    setType(typeGPIO);
}

int ActionGPIO::getIdGPIO() const
{
    return idGPIO;
}

void ActionGPIO::setIdGPIO(int value)
{
    idGPIO = value;
}

int ActionGPIO::getValueGPIO() const
{
    return valueGPIO;
}

void ActionGPIO::setValueGPIO(int value)
{
    valueGPIO = value;
}

void ActionGPIO::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("actionGPIO");
    xmlWriter->writeTextElement("id",QString::number(getIdGPIO(),'f',0));
    xmlWriter->writeTextElement("value",QString::number(getValueGPIO(),'f',0));
    xmlWriter->writeEndElement();
}

void ActionGPIO::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionGPIO");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("id", QString::number(getIdGPIO(),'f',0).toStdString().c_str());
        param->SetAttribute("value", QString::number(getValueGPIO(),'f',0).toStdString().c_str());
        break;
    }
}
