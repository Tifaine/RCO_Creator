#include "attenteblocage.h"

AttenteBlocage::AttenteBlocage()
{

}

int AttenteBlocage::getSensibilite() const
{
    return sensibilite;
}

void AttenteBlocage::setSensibilite(int value)
{
    sensibilite = value;
}

void AttenteBlocage::saveXML(QXmlStreamWriter *xmlWriter)
{
    xmlWriter->writeStartElement("actionAttenteBlocage");
    xmlWriter->writeTextElement("sensibilite",QString::number(getSensibilite(),'f',0));
    xmlWriter->writeEndElement();
}

void AttenteBlocage::saveXML(TiXmlElement * root, int indice)
{
    switch(indice)
    {
    case 1:
        root->SetAttribute("type", "actionAttenteBlocage");
        break;
    case 2:
        TiXmlElement * param = new TiXmlElement( "parametres" );
        root->LinkEndChild( param );
        param->SetAttribute("sensibilite", QString::number(getSensibilite(),'f',0).toStdString().c_str());
        break;
    }
}
