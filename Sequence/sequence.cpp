#include "sequence.h"

Sequence::Sequence(QQuickItem *parent) : QQuickItem(parent)
{

}

void Sequence::ajouterAction(Action* essai)
{
    listAction.append(essai);
}

void Sequence::enregistrerSous(QString filename)
{
    QStringList listNom = filename.split('/');
    QString nomLast = listNom.last();
    if(nomLast.contains(".xml"))
    {
        nomLast = nomLast.left(nomLast.size()-4);
    }
    filename = nomLast+".xml";
    QFile file(filename);
    if(file.open(QIODevice::WriteOnly))
    {
        QString element;
        QXmlStreamWriter xmlWriter(&file);
        xmlWriter.setAutoFormatting(true);
        xmlWriter.writeStartDocument();
        xmlWriter.writeStartElement("Sequence");
        xmlWriter.writeTextElement("version",element.number(3,'f',0));
        for(int i=0;i<listAction.size();i++)
        {
            listAction.at(i)->saveXML(&xmlWriter);
        }
        xmlWriter.writeEndElement();
        xmlWriter.writeEndDocument();
        file.close();
    }
}
