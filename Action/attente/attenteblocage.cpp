#include "attenteblocage.h"

AttenteBlocage::AttenteBlocage()
{

}

int AttenteBlocage::getTemps() const
{
    return temps;
}

void AttenteBlocage::setTemps(int value)
{
    temps = value;
}

void AttenteBlocage::saveXML(QXmlStreamWriter *xmlWriter)
{
    xmlWriter->writeStartElement("actionAttenteBlocage");
    xmlWriter->writeTextElement("valueAttente",QString::number(getTemps(),'f',0));
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
        break;
    }
}
