#include "retourgpio.h"

RetourGPIO::RetourGPIO()
{

}

int RetourGPIO::getIdGPIO() const
{
    return idGPIO;
}

void RetourGPIO::setIdGPIO(int value)
{
    idGPIO = value;
}

int RetourGPIO::getValueGPIO() const
{
    return valueGPIO;
}

void RetourGPIO::setValueGPIO(int value)
{
    valueGPIO = value;
}

void RetourGPIO::saveXML(QXmlStreamWriter* xmlWriter)
{
    xmlWriter->writeStartElement("retourGPIO");
    xmlWriter->writeTextElement("id",QString::number(getIdGPIO(),'f',0));
    xmlWriter->writeTextElement("value",QString::number(getValueGPIO(),'f',0));
    xmlWriter->writeEndElement();
}

void RetourGPIO::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "retourGPIO");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("id", QString::number(getIdGPIO(),'f',0).toStdString().c_str());
        param->SetAttribute("value", QString::number(getValueGPIO(),'f',0).toStdString().c_str());
        break;
    }
}
