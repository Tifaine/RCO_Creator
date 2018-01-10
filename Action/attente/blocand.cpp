#include "blocand.h"

BlocAND::BlocAND()
{

}

void BlocAND::saveXML(QXmlStreamWriter *xmlWriter)
{
    xmlWriter->writeStartElement("actionBlocAND");
    xmlWriter->writeEndElement();
}

void BlocAND::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionBlocAND");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("AND", "so_On");
        break;
    }
}
