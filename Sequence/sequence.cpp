#include "sequence.h"

Sequence::Sequence(QQuickItem *parent) : QQuickItem(parent)
{

}

void Sequence::ajouterAction(Action* essai)
{
    listAction.append(essai);
}

void Sequence::supprimerAction(Action * toBeDeleted)
{
    listAction.removeAt(listAction.indexOf(toBeDeleted));
}

void Sequence::clearAll()
{
    listAction.clear();
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
        xmlWriter.writeTextElement("TypeXml","Scenario");
        xmlWriter.writeStartElement("Sequence");
        xmlWriter.writeTextElement("version",element.number(3,'f',0));

        for(int i=0;i<listAction.size();i++)
        {
            xmlWriter.writeStartElement("Action");
            xmlWriter.writeTextElement("ActionNumero",QString::number(i));
            xmlWriter.writeTextElement("xBloc",QString::number(listAction.at(i)->getXBloc()));
            xmlWriter.writeTextElement("yBloc",QString::number(listAction.at(i)->getYBloc()));
            if(listAction.at(i)->getTimeOut() != -1)
            {
                xmlWriter.writeTextElement("timeOut",QString::number(listAction.at(i)->getTimeOut()));
            }


            for(int j=0;j<listAction.at(i)->getListFils().size();j++)
            {
                QString listFils;
                listFils.clear();
                for(int k=0;k<listAction.at(i)->getListFils().at(j)->size();k++)
                {
                    listFils.append(QString::number(listAction.indexOf(listAction.at(i)->getListFils().at(j)->at(k))));
                    listFils.append(";");
                }
                if(j == listAction.at(i)->getListFils().size() -1 && j != 0)
                {
                    xmlWriter.writeTextElement("ListTimeOut",listFils);
                }else
                {
                  xmlWriter.writeTextElement("ListFils",listFils);
                }
            }

            for(int j=0;j<listAction.at(i)->getListPere().size();j++)
            {
                QString listPere;
                listPere.clear();
                for(int k=0;k<listAction.at(i)->getListPere().at(j)->size();k++)
                {
                    listPere.append(QString::number(listAction.indexOf(listAction.at(i)->getListPere().at(j)->at(k))));
                    listPere.append(";");
                }
                xmlWriter.writeTextElement("ListPere",listPere);

            }

            listAction.at(i)->saveXML(&xmlWriter);
            xmlWriter.writeEndElement();
        }
        xmlWriter.writeEndElement();
        xmlWriter.writeEndDocument();
        file.close();
    }
}
