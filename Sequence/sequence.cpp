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

void Sequence::mirror()
{
    for(int i=0;i<listAction.size();i++)
    {
        if(listAction.at(i)->getType()==typePosition)
        {
            ActionPosition* temp = (ActionPosition*)listAction.at(i);
            temp->setXRobot(-1*temp->getXRobot());
        }else if(listAction.at(i)->getType()==typeOrientation)
        {
            ActionOrientation* temp = (ActionOrientation*)listAction.at(i);
            if(temp->getAngle()>=0)
            {
                temp->setAngle(180.- temp->getAngle());
            }else
            {
                temp->setAngle(-180. + temp->getAngle());
            }
        }
    }
}

void Sequence::clearAll()
{
    listAction.clear();
}

int Sequence::getNbAction()
{
    return listAction.size();
}

int Sequence::getIndice(Action* act)
{
    return listAction.indexOf(act);
}

void Sequence::enregistrerSous(QString filename)
{
    if(filename.contains(".xml"))
    {
        filename = filename.left(filename.size()-4);
    }
    filename = filename+".xml";
    filename = filename.right(filename.size()-7);
    TiXmlDocument doc;
    TiXmlElement* msg;
    TiXmlDeclaration* decl = new TiXmlDeclaration( "1.0", "UTF-8", "" );
    doc.LinkEndChild( decl );

    msg = new TiXmlElement( "typeXml" );
    msg->SetAttribute("key", QDateTime::currentDateTimeUtc().toString().toStdString().c_str());
    msg->LinkEndChild( new TiXmlText( "scenario" ));
    doc.LinkEndChild( msg );

    TiXmlElement * root = new TiXmlElement( "Sequence" );
    doc.LinkEndChild( root );
    msg = new TiXmlElement( "version" );
    msg->LinkEndChild( new TiXmlText( "3.1" ));
    root->LinkEndChild( msg );
    for(int i=0;i<listAction.size();i++)
    {
        TiXmlElement * action = new TiXmlElement( "Action" );
        root->LinkEndChild( action );
        listAction.at(i)->saveXML(action,1);
        action->SetAttribute("numero", i);

        if(listAction.at(i)->getTimeOut()!=-1)
        {
            action->SetAttribute("timeout", listAction.at(i)->getTimeOut());
        }

        TiXmlElement * posBloc = new TiXmlElement( "bloc" );
        action->LinkEndChild( posBloc );
        posBloc->SetAttribute("x", listAction.at(i)->getXBloc());
        posBloc->SetAttribute("y", listAction.at(i)->getYBloc());

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
                TiXmlElement * posBloc = new TiXmlElement( "timeout" );
                action->LinkEndChild( posBloc );
                posBloc->SetAttribute("liste", listFils.toStdString().c_str());
            }else
            {
                TiXmlElement * posBloc = new TiXmlElement( "fils" );
                action->LinkEndChild( posBloc );
                posBloc->SetAttribute("liste", listFils.toStdString().c_str());
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
            TiXmlElement * posBloc = new TiXmlElement( "pere" );
            action->LinkEndChild( posBloc );
            posBloc->SetAttribute("liste", listPere.toStdString().c_str());
        }

        QString listNumberIn;
        listNumberIn.clear();
        for(int j=0;j<listAction.at(i)->getListNumberIn().size();j++)
        {
            listNumberIn.append(QString::number(listAction.indexOf(listAction.at(i)->getListNumberIn().at(j))));
        }
        listAction.at(i)->saveXML(action,2);
    }
    doc.SaveFile( filename.toStdString().c_str() );
}

void Sequence::exportXML()
{

    QString filename("/tmp/temp.xml");

    TiXmlDocument doc;
    TiXmlElement* msg;
    TiXmlDeclaration* decl = new TiXmlDeclaration( "1.0", "UTF-8", "" );
    doc.LinkEndChild( decl );

    msg = new TiXmlElement( "typeXml" );
    msg->SetAttribute("key", QDateTime::currentDateTimeUtc().toString().toStdString().c_str());
    msg->LinkEndChild( new TiXmlText( "scenario" ));
    doc.LinkEndChild( msg );

    TiXmlElement * root = new TiXmlElement( "Sequence" );
    doc.LinkEndChild( root );
    msg = new TiXmlElement( "version" );
    msg->LinkEndChild( new TiXmlText( "3.1" ));
    root->LinkEndChild( msg );
    indice = 0;
    for(int i=0;i<listAction.size();i++)
    {
        if(listAction.at(i)->getType() != typeSequence)
        {
            indice++;
            TiXmlElement * action = new TiXmlElement( "Action" );
            root->LinkEndChild( action );
            listAction.at(i)->saveXML(action,1);
            action->SetAttribute("numero", i);

            if(listAction.at(i)->getTimeOut()!=-1)
            {
                action->SetAttribute("timeout", listAction.at(i)->getTimeOut());
            }

            TiXmlElement * posBloc = new TiXmlElement( "bloc" );
            action->LinkEndChild( posBloc );
            posBloc->SetAttribute("x", listAction.at(i)->getXBloc());
            posBloc->SetAttribute("y", listAction.at(i)->getYBloc());

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
                    TiXmlElement * posBloc = new TiXmlElement( "timeout" );
                    action->LinkEndChild( posBloc );
                    posBloc->SetAttribute("liste", listFils.toStdString().c_str());


                }else
                {
                    TiXmlElement * posBloc = new TiXmlElement( "fils" );
                    action->LinkEndChild( posBloc );
                    posBloc->SetAttribute("liste", listFils.toStdString().c_str());
                }
            }

            if(listAction.at(i)->getType() != typeEntree)
            {
                for(int j=0;j<listAction.at(i)->getListPere().size();j++)
                {
                    QString listPere;
                    listPere.clear();
                    for(int k=0;k<listAction.at(i)->getListPere().at(j)->size();k++)
                    {
                        listPere.append(QString::number(listAction.indexOf(listAction.at(i)->getListPere().at(j)->at(k))));
                        listPere.append(";");
                    }
                    TiXmlElement * posBloc = new TiXmlElement( "pere" );
                    action->LinkEndChild( posBloc );
                    posBloc->SetAttribute("liste", listPere.toStdString().c_str());
                }

            }

            QString listNumberIn;
            listNumberIn.clear();
            for(int j=0;j<listAction.at(i)->getListNumberIn().size();j++)
            {
                listNumberIn.append(QString::number(listAction.indexOf(listAction.at(i)->getListNumberIn().at(j))));
            }
            listAction.at(i)->saveXML(action,2);
        }else
        {

            QList<Action*> listAct;
            ActionSequence* temp = (ActionSequence*)listAction.at(i);
            ouvrirSequence(temp->getNomSequence(),&listAct);
            enregistrerSequence(root,&listAct,indice+listAction.size(),i,&listAction,0);
            indice+=listAct.size();

        }
    }
    doc.SaveFile( filename.toStdString().c_str() );
}

void Sequence::enregistrerSequence(TiXmlElement * root, QList<Action*>* listActionSequence, int indice, int indiceDebut, QList<Action*>* listRef,int delta)
{

    for(int i=0;i<listActionSequence->size();i++)
    {
        if(listActionSequence->at(i)->getType() != typeSequence)
        {
            TiXmlElement * action = new TiXmlElement( "Action" );
            root->LinkEndChild( action );
            listActionSequence->at(i)->saveXML(action,1);
            if(i!=0)
            {

                action->SetAttribute("numero", indice+i);
            }else
            {
                action->SetAttribute("numero", indiceDebut+delta);
            }

            if(listActionSequence->at(i)->getTimeOut()!=-1)
            {
                action->SetAttribute("timeout", listActionSequence->at(i)->getTimeOut());
            }
            if(listActionSequence->at(i)->getType()!=typeFin)
            {

                for(int j=0;j<listActionSequence->at(i)->getListFils().size();j++)
                {
                    QString listFils;
                    listFils.clear();
                    for(int k=0;k<listActionSequence->at(i)->getListFils().at(j)->size();k++)
                    {
                        listFils.append(QString::number(listActionSequence->indexOf(listActionSequence->at(i)->getListFils().at(j)->at(k))+indice));
                        listFils.append(";");
                    }

                    if(j == listActionSequence->at(i)->getListFils().size() -1 && j != 0)
                    {
                        TiXmlElement * posBloc = new TiXmlElement( "timeout" );
                        action->LinkEndChild( posBloc );
                        posBloc->SetAttribute("liste", listFils.toStdString().c_str());
                    }else
                    {
                        TiXmlElement * posBloc = new TiXmlElement( "fils" );
                        action->LinkEndChild( posBloc );
                        posBloc->SetAttribute("liste", listFils.toStdString().c_str());
                    }
                }
            }else
            {
                for(int j=0;j<listRef->at(indiceDebut)->getListFils().size();j++)
                {
                    QString listFils;
                    listFils.clear();
                    for(int k=0;k<listRef->at(indiceDebut)->getListFils().at(j)->size();k++)
                    {
                        listFils.append(QString::number(listRef->indexOf(listRef->at(indiceDebut)->getListFils().at(j)->at(k))+delta));
                        listFils.append(";");
                    }
                    if(j == listRef->at(indiceDebut)->getListFils().size() -1 && j != 0)
                    {
                        TiXmlElement * posBloc = new TiXmlElement( "timeout" );
                        action->LinkEndChild( posBloc );
                        posBloc->SetAttribute("liste", listFils.toStdString().c_str());

                    }else
                    {
                        TiXmlElement * posBloc = new TiXmlElement( "fils" );
                        action->LinkEndChild( posBloc );
                        posBloc->SetAttribute("liste", listFils.toStdString().c_str());
                    }
                }
            }

            if(i!=0)
            {
                for(int j=0;j<listActionSequence->at(i)->getListPere().size();j++)
                {
                    QString listPere;
                    listPere.clear();
                    for(int k=0;k<listActionSequence->at(i)->getListPere().at(j)->size();k++)
                    {
                        listPere.append(QString::number(listActionSequence->indexOf(listActionSequence->at(i)->getListPere().at(j)->at(k))));
                        listPere.append(";");
                    }
                    TiXmlElement * posBloc = new TiXmlElement( "pere" );
                    action->LinkEndChild( posBloc );
                    posBloc->SetAttribute("liste", listPere.toStdString().c_str());
                }
            }else
            {
//                for(int j=0;j<listRef->at(indiceDebut)->getListPere().size();j++)
//                {
//                    QString listPere;
//                    listPere.clear();
//                    for(int k=0;k<listRef->at(indiceDebut)->getListPere().at(j)->size();k++)
//                    {
//                        listPere.append(QString::number(listRef->indexOf(listRef->at(indiceDebut)->getListPere().at(j)->at(k))));
//                        listPere.append(";");
//                    }
//                    TiXmlElement * posBloc = new TiXmlElement( "pere" );
//                    action->LinkEndChild( posBloc );
//                    posBloc->SetAttribute("liste", listPere.toStdString().c_str());
//                }
            }

            listActionSequence->at(i)->saveXML(action,2);
        }else
        {

           /* QList<Action*> listAct;
            ActionSequence* temp = (ActionSequence*)listAction.at(i);
            ouvrirSequence(temp->getNomSequence(),&listAct);
            enregistrerSequence(root,&listAct,indice+listAction.size(),i,&listAction,0);
            indice+=listAct.size();*/

            QList<Action*> listAct;
            ActionSequence* temp = (ActionSequence*)listActionSequence->at(i);
            ouvrirSequence(temp->getNomSequence(),&listAct);
            enregistrerSequence(root,&listAct,i+listActionSequence->size()+indiceDebut,i,listActionSequence,i);
            indice+=listActionSequence->size();
        }
    }
}

int Sequence::ouvrirSequence(QString sequenceName, QList<Action*>* listAction)
{
    int _type = -1;
    int xBloc = -1;
    int yBloc = -1;
    int timeOut = -1;
    QString listPere, listFils, listTimeout, param0, param1, param2, param3, param4, param5, param6, param7,param8;
    int rc = 0;
    if(sequenceName.left(4)=="file")
    {
        sequenceName = sequenceName.right(sequenceName.size()-7);
    }
    sequenceName = "scripts/"+sequenceName;
    TiXmlDocument doc(sequenceName.toStdString().c_str());
    if(!doc.LoadFile())
    {
        return -1;
    }

    TiXmlElement* root = doc.FirstChildElement();

    std::string elemNameRoot = root->Value();
    if(elemNameRoot == "typeXml")
    {
        TiXmlNode* e = root->FirstChild();
        if(e!=NULL)
        {
            TiXmlText* text = e->ToText();
            std::string s = text->Value();
            if(s.compare("scenario")!=0)
            {
                return -1;
            }
        }
        root = root->NextSiblingElement();
    }else
    {
        return -1;
    }

    for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
    {

        std::string elemName = elem->Value();

        if(elemName == "version")
        {
            TiXmlNode* e = elem->FirstChild();
            if(e!=NULL)
            {
                TiXmlText* text = e->ToText();
                std::string s = text->Value();
            }
        }else if(elemName == "Action")
        {
            if(elem->Attribute("type"))
            {
                std::string type = elem->Attribute("type");
                if(type=="actionDepart")
                {
                    _type = typeEntree;
                    listAction->append(new ActionDepart);
                }else if(type == "actionMoteur")
                {
                    _type = typeMoteur;
                    listAction->append(new ActionMoteur);
                }else if(type == "actionDyna")
                {
                    _type = typeDyna;
                    listAction->append(new ActionDynamixel);
                }else if(type == "actionGPIO")
                {
                    _type = typeGPIO;
                    listAction->append(new ActionGPIO);
                }else if(type == "actionSequence")
                {
                    _type = typeSequence;
                    listAction->append(new ActionSequence);
                }else if(type == "actionPause")
                {
                    listAction->append(new AttenteTemps);
                    _type = typeAttenteTemps;
                }else if(type == "actionPosition")
                {
                    listAction->append(new ActionPosition);
                    _type = typePosition;
                }else if(type == "actionRetourDeplacement")
                {
                    //listAction->append(new RetourPosition);
                    _type = typeRetourDeplacement;
                }else if(type == "actionRetourDyna")
                {
                    listAction->append(new AttenteDyna);
                    _type = typeAttenteDyna;
                }else if(type == "retourGPIO")
                {
                    listAction->append(new RetourGPIO);
                    _type = typeRetourGPIO;
                }else if(type == "actionRetourPosition")
                {
                    listAction->append(new RetourPosition);
                    _type = typeRetourPosition;
                }else if(type == "actionRetourRotation")
                {
                    listAction->append(new RetourOrientation);
                    _type = typeRetourOrientation;
                }else if(type == "actionRotation")
                {
                    listAction->append(new ActionOrientation);
                    _type = typeOrientation;
                }else if(type == "actionServo")
                {
                    listAction->append(new ActionServo);
                    _type =  typeServo;
                }else if(type == "actionBlocAND")
                {
                    listAction->append(new BlocAND);
                    _type =  typeAND;
                }else if(type == "actionValeur")
                {
                    listAction->append(new ActionSetValeur);
                    _type =  typeSetValeur;
                }else if(type == "actionArc")
                {
                    listAction->append(new ActionCourbe);
                    _type =  typeCourbe;
                }else if(type == "actionRetourBlocage")
                {
                    listAction->append(new AttenteBlocage);
                    _type =  typeAttenteBlocage;
                }else if(type == "actionDeplacement")
                {
                    listAction->append(new ActionDeplacement);
                    _type =  typeDeplacement;
                }else if(type == "actionFin")
                {

                    listAction->append(new ActionFin);
                    _type =  typeFin;
                }
            }


            // genererAction(xBloc, yBloc, _type, listPere, listFils,param0,param1,param2,param3,param4,param5,param6,param7,param8);
        }
    }
    if(!doc.LoadFile())
    {
        return -1;
    }
    int indice = 0;
    root = doc.FirstChildElement();
    elemNameRoot = root->Value();
    if(elemNameRoot == "typeXml")
    {
        TiXmlNode* e = root->FirstChild();
        if(e!=NULL)
        {
            TiXmlText* text = e->ToText();
            std::string s = text->Value();
            if(s.compare("scenario")!=0)
            {
                return -1;
            }
        }
        root = root->NextSiblingElement();
    }else
    {
        return -1;
    }

    for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
    {
        std::string elemName = elem->Value();
        if(elemName == "Action")
        {

            if(elem->Attribute("type"))
            {
                std::string type = elem->Attribute("type");
                if(type=="actionDepart")
                {
                    _type = typeEntree;
                }else if(type == "actionMoteur")
                {
                    _type = typeMoteur;
                }else if(type == "actionDyna")
                {
                    _type = typeDyna;
                }else if(type == "actionGPIO")
                {
                    _type = typeGPIO;
                }else if(type == "actionSequence")
                {
                    _type = typeSequence;
                }else if(type == "actionPause")
                {
                    _type = typeAttenteTemps;
                }else if(type == "actionPosition")
                {
                    _type = typePosition;
                }else if(type == "actionRetourDeplacement")
                {
                    _type = typeRetourDeplacement;
                }else if(type == "actionRetourDyna")
                {
                    _type = typeAttenteDyna;
                }else if(type == "retourGPIO")
                {
                    _type = typeRetourGPIO;
                }else if(type == "actionRetourPosition")
                {
                    _type = typeRetourPosition;
                }else if(type == "actionRetourRotation")
                {
                    _type = typeRetourOrientation;
                }else if(type == "actionRotation")
                {
                    _type = typeOrientation;
                }else if(type == "actionServo")
                {
                    _type =  typeServo;
                }else if(type == "actionBlocAND")
                {
                    _type =  typeAND;
                }else if(type == "actionValeur")
                {
                    _type =  typeSetValeur;
                }else if(type == "actionArc")
                {
                    _type =  typeCourbe;
                }else if(type == "actionRetourBlocage")
                {
                    _type =  typeAttenteBlocage;
                }else if(type == "actionDeplacement")
                {
                    _type =  typeDeplacement;
                }else if(type == "actionFin")
                {
                    _type =  typeFin;
                }
            }

            if(elem->Attribute("timeout"))
            {
                timeOut = atoi(elem->Attribute("timeout"));
                listAction->at(indice)->setTimeOut(timeOut);
            }

            for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
            {
                std::string elemNameBis = elemBis->Value();
                if(elemNameBis == "pere")
                {
                    if(elemBis->Attribute("liste"))
                    {
                        listPere = QString::fromStdString(elemBis->Attribute("liste"));
                        QStringList temp = listPere.split(";");
                        listAction->at(indice)->ajouterListPere();
                        listAction->at(indice)->getListPere().clear();
                        for(int i=0;i<temp.size()-1;i++)
                        {
                            listAction->at(indice)->ajouterPere(0,listAction->at(temp.at(i).toInt()));
                        }
                    }
                }else if(elemNameBis == "fils")
                {
                    if(elemBis->Attribute("liste"))
                    {
                        listFils = QString::fromStdString(elemBis->Attribute("liste"));
                        QStringList temp = listFils.split(";");
                        listAction->at(indice)->ajouterListFils();
                        listAction->at(indice)->getListFils().clear();

                        for(int i=0;i<temp.size()-1;i++)
                        {
                            listAction->at(indice)->ajouterFils(0,listAction->at(temp.at(i).toInt()));
                        }
                    }
                }else if(elemNameBis == "timeout")
                {
                    if(elemBis->Attribute("liste"))
                    {
                        listTimeout = QString::fromStdString(elemBis->Attribute("liste"));
                        QStringList temp = listTimeout.split(";");
                        listAction->at(indice)->ajouterListFils();
                        for(int i=0;i<temp.size()-1;i++)
                        {
                            listAction->at(indice)->ajouterFils(1,listAction->at(temp.at(i).toInt()));
                        }
                    }
                }else if(elemNameBis == "parametres")
                {
                    switch(_type)
                    {
                    case typeServo:

                        if(elemBis->Attribute("nom"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("nom"));
                            ActionServo* temp = (ActionServo*) listAction->at(indice);
                            temp->setNomServo(param2);
                        }
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            ActionServo* temp = (ActionServo*) listAction->at(indice);
                            temp->setIdServo(param0.toInt());
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("angle"));
                            ActionServo* temp = (ActionServo*) listAction->at(indice);
                            temp->setValueServo(param1.toInt());
                        }
                        break;
                    case typeDyna:
                    {
                        ActionDynamixel* temp = (ActionDynamixel*) listAction->at(indice);
                        if(elemBis->Attribute("nom"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("nom"));
                            temp->setNomDyna(param3);
                        }
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            temp->setIdDyna(param0.toInt());
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("angle"));
                            temp->setValueDyna(param1.toInt());
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("vitesse"));
                            temp->setVitesseDyna(param2.toInt());
                        }


                        break;
                    }
                    case typeCapteur:
                        break;
                    case typeMoteur:
                    {
                        ActionMoteur* temp = (ActionMoteur*) listAction->at(indice);
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            temp->setIdMoteur(param0.toInt());
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                            temp->setValueMoteur(param1.toInt());
                        }
                        break;
                    }
                    case typeAutre:
                        break;
                    case typePosition:
                    {
                        ActionPosition* temp = (ActionPosition*)listAction->at(indice);
                        if(elemBis->Attribute("x"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("x"));
                            temp->setXRobot(param0.toInt());
                        }
                        if(elemBis->Attribute("y"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("y"));
                            temp->setYRobot(param1.toInt());
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("vitesse"));
                            temp->setVitesse(param2.toInt());
                        }
                        if(elemBis->Attribute("acc"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("acc"));
                            temp->setAcceleration(param3.toInt());
                        }
                        if(elemBis->Attribute("dec"))
                        {
                            param4 = QString::fromStdString(elemBis->Attribute("dec"));
                            temp->setDeceleration(param4.toInt());
                        }
                        if(elemBis->Attribute("sens"))
                        {
                            param5 = QString::fromStdString(elemBis->Attribute("sens"));
                            if(param5.compare("0")==0)
                            {
                                temp->setSens(false);
                            }else
                            {
                                temp->setSens(true);
                            }
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param6 = QString::fromStdString(elemBis->Attribute("precision"));
                            temp->setPrecision(param6.toInt());
                        }

                        break;
                    }
                    case typeOrientation:
                    {
                        ActionOrientation* temp = (ActionOrientation*)listAction->at(indice);
                        if(elemBis->Attribute("angle"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("angle"));
                            temp->setAngle(param0.toInt());
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("precision"));
                            temp->setPrecision(param1.toInt());
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("vitesse"));
                            temp->setVitesse(param3.toInt());
                        }
                        break;
                    }
                    case typeSequence:
                    {
                        ActionSequence* temp = (ActionSequence*)listAction->at(indice);
                        if(elemBis->Attribute("nomSequence"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("nomSequence"));
                            temp->setNomSequence(param0);
                        }
                        break;
                    }
                    case typeEntree:
                        //genererAction(xBloc, yBloc, _type, listPere, listFils,0,0,0,0,0,0);
                        break;
                    case typeGPIO:
                    {
                        ActionGPIO* temp = (ActionGPIO*)listAction->at(indice);
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            temp->setIdGPIO(param0.toInt());
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                            temp->setValueGPIO(param1.toInt());
                        }
                        break;
                    }

                    case typeAttenteServo:
                        break;
                    case typeAttenteDyna:
                    {
                        AttenteDyna* temp = (AttenteDyna*) listAction->at(indice);
                        if(elemBis->Attribute("nom"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("nom"));
                            temp->setNomDyna(param2);
                        }
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            temp->setIdDyna(param0.toInt());
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("angle"));
                            temp->setValueDyna(param1.toInt());
                            temp->setType(param5.toInt());
                        }
                        if(elemBis->Attribute("load"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("load"));
                            temp->setValueDyna(param1.toInt());
                            temp->setType(param5.toInt());
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("angle"));

                        }
                        if(elemBis->Attribute("type"))
                        {
                            param5 = QString::fromStdString(elemBis->Attribute("type"));
                        }
                        break;
                    }
                    case typeAttenteTemps:
                    {
                        AttenteTemps* temp = (AttenteTemps*)listAction->at(indice);

                        if(elemBis->Attribute("temps"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("temps"));
                            temp->setTemps(param0.toInt());
                            qDebug()<<"Ouverture : "<<temp->getTemps();
                        }

                        break;
                    }
                    case typeRetourDeplacement:

                        break;
                    case typeRetourOrientation:
                    {
                        RetourOrientation* temp = (RetourOrientation*)listAction->at(indice);
                        if(elemBis->Attribute("rotation"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("rotation"));
                            temp->setOrientation(param0.toInt());
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("precision"));
                            temp->setPrecision(param1.toInt());
                        }
                        //genererAction(xBloc, yBloc, typeRetourOrientation, listPere, listFils,QString::number(orientation),QString::number(precision),listTimeout,QString::number(timeout),0,0);

                        break;
                    }
                    case typeRetourPosition:
                    {
                        RetourPosition* temp = (RetourPosition*)listAction->at(indice);
                        if(elemBis->Attribute("x"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("x"));
                            temp->setXRobot(param0.toInt());
                        }
                        if(elemBis->Attribute("y"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("y"));
                            temp->setYRobot(param1.toInt());
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("precision"));
                            temp->setPrecision(param2.toInt());
                        }

                        //genererAction(xBloc, yBloc, typeRetourPosition, listPere, listFils,QString::number(coordX),QString::number(coordY),QString::number(precision),listTimeout,QString::number(timeout),0);
                        break;
                    }
                    case typeRetourGPIO:
                    {
                        RetourGPIO* temp = (RetourGPIO*)listAction->at(indice);
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            temp->setIdGPIO(param0.toInt());
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                            temp->setValueGPIO(param1.toInt());
                        }

                        break;
                    }
                    case typeAND:

                        break;
                    case typeSetValeur:
                    {
                        ActionSetValeur* temp = (ActionSetValeur*)listAction->at(indice);
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            temp->setIdValeur(param0.toInt());
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                            temp->setValueValeur(param1.toInt());
                        }
                        break;
                    }
                    case typeDeplacement:
                    {
                        ActionDeplacement* temp = (ActionDeplacement*)listAction->at(indice);
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                            temp->setIdValeur(param0.toInt());
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                            temp->setValueValeur(param1.toInt());
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("vitesse"));
                            temp->setVitesse(param2.toInt());
                        }
                        break;
                    }
                    case typeCourbe:
                    {
                        ActionCourbe* temp = (ActionCourbe*)listAction->at(indice);
                        if(elemBis->Attribute("vitesse"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("vitesse"));
                            temp->setVitesse(param0.toInt());
                        }
                        if(elemBis->Attribute("rayon"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("rayon"));
                            temp->setRayon(param1.toInt());
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("angle"));
                            temp->setAngle(param2.toInt());
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("precision"));
                            temp->setPrecision(param3.toInt());
                        }
                        if(elemBis->Attribute("sens"))
                        {
                            param5 = QString::fromStdString(elemBis->Attribute("sens"));
                            if(param5.compare("0")==0)
                            {
                                temp->setSens(false);
                            }else
                            {
                                temp->setSens(true);
                            }
                        }
                        break;
                    }
                    case typeAttenteBlocage:
                    {
                        AttenteBlocage* temp = (AttenteBlocage*)listAction->at(indice);
                        if(elemBis->Attribute("sensibilite"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("sensibilite"));
                            temp->setSensibilite(param2.toInt());
                        }

                        break;
                    }
                    }
                }
            }
            indice++;
        }
    }

}



int Sequence::ouvrirFichier(QString fileName)
{
    int _type = -1;
    int xBloc = -1;
    int yBloc = -1;
    int timeOut = -1;
    QString listPere, listFils, listTimeout, param0, param1, param2, param3, param4, param5, param6, param7,param8;
    int rc = 0;
    if(fileName.left(4)=="file")
    {
        fileName = fileName.right(fileName.size()-7);
    }
    TiXmlDocument doc(fileName.toStdString().c_str());
    if(!doc.LoadFile())
    {
        return -1;
    }

    TiXmlElement* root = doc.FirstChildElement();

    std::string elemNameRoot = root->Value();
    if(elemNameRoot == "typeXml")
    {
        TiXmlNode* e = root->FirstChild();
        if(e!=NULL)
        {
            TiXmlText* text = e->ToText();
            std::string s = text->Value();
            if(s.compare("scenario")!=0)
            {
                return -1;
            }
        }
        root = root->NextSiblingElement();
    }else
    {
        return -1;
    }

    for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
    {

        std::string elemName = elem->Value();
        if(elemName == "version")
        {
            TiXmlNode* e = elem->FirstChild();
            if(e!=NULL)
            {
                TiXmlText* text = e->ToText();
                std::string s = text->Value();
            }
        }else if(elemName == "Action")
        {

            if(elem->Attribute("type"))
            {
                std::string type = elem->Attribute("type");
                if(type=="actionDepart")
                {
                    _type = typeEntree;
                }else if(type == "actionMoteur")
                {
                    _type = typeMoteur;
                }else if(type == "actionDyna")
                {
                    _type = typeDyna;
                }else if(type == "actionGPIO")
                {
                    _type = typeGPIO;
                }else if(type == "actionSequence")
                {
                    _type = typeSequence;
                }else if(type == "actionPause")
                {
                    _type = typeAttenteTemps;
                }else if(type == "actionPosition")
                {
                    _type = typePosition;
                }else if(type == "actionRetourDeplacement")
                {
                    _type = typeRetourDeplacement;
                }else if(type == "actionRetourDyna")
                {
                    _type = typeAttenteDyna;
                }else if(type == "retourGPIO")
                {
                    _type = typeRetourGPIO;
                }else if(type == "actionRetourPosition")
                {
                    _type = typeRetourPosition;
                }else if(type == "actionRetourRotation")
                {
                    _type = typeRetourOrientation;
                }else if(type == "actionRotation")
                {
                    _type = typeOrientation;
                }else if(type == "actionServo")
                {
                    _type =  typeServo;
                }else if(type == "actionBlocAND")
                {
                    _type =  typeAND;
                }else if(type == "actionValeur")
                {
                    _type =  typeSetValeur;
                }else if(type == "actionArc")
                {
                    _type =  typeCourbe;
                }else if(type == "actionRetourBlocage")
                {
                    _type =  typeAttenteBlocage;
                }else if(type == "actionDeplacement")
                {
                    _type =  typeDeplacement;
                }else if(type == "actionFin")
                {

                    _type =  typeFin;
                }
            }
            if(elem->Attribute("numero"))
            {

            }
            if(elem->Attribute("timeout"))
            {
                timeOut = atoi(elem->Attribute("timeout"));
            }

            for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
            {
                std::string elemNameBis = elemBis->Value();
                if(elemNameBis == "pere")
                {
                    if(elemBis->Attribute("liste"))
                    {
                        listPere = QString::fromStdString(elemBis->Attribute("liste"));
                    }
                }else if(elemNameBis == "fils")
                {
                    if(elemBis->Attribute("liste"))
                    {
                        listFils = QString::fromStdString(elemBis->Attribute("liste"));
                    }
                }else if(elemNameBis == "timeout")
                {
                    if(elemBis->Attribute("liste"))
                    {
                        listTimeout = QString::fromStdString(elemBis->Attribute("liste"));
                    }
                }else if(elemNameBis == "parametres")
                {
                    switch(_type)
                    {
                    case typeServo:
                        if(elemBis->Attribute("nom"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("nom"));
                        }
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("angle"));
                        }
                        break;
                    case typeDyna:

                        if(elemBis->Attribute("nom"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("nom"));
                        }
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("angle"));
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("vitesse"));
                        }

                        break;
                    case typeCapteur:
                        break;
                    case typeMoteur:
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                        }
                        break;
                    case typeAutre:
                        break;
                    case typePosition:
                        if(elemBis->Attribute("x"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("x"));
                        }
                        if(elemBis->Attribute("y"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("y"));
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("vitesse"));
                        }
                        if(elemBis->Attribute("acc"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("acc"));
                        }
                        if(elemBis->Attribute("dec"))
                        {
                            param4 = QString::fromStdString(elemBis->Attribute("dec"));
                        }
                        if(elemBis->Attribute("sens"))
                        {
                            param5 = QString::fromStdString(elemBis->Attribute("sens"));
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param6 = QString::fromStdString(elemBis->Attribute("precision"));
                        }
                        param7 = QString::number(timeOut);
                        param8 = listTimeout;

                        break;
                    case typeOrientation:
                        if(elemBis->Attribute("angle"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("angle"));
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("precision"));
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("vitesse"));
                        }
                        param2 = QString::number(timeOut);
                        param4 = listTimeout;
                        break;

                    case typeSequence:
                        if(elemBis->Attribute("nomSequence"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("nomSequence"));
                        }
                        break;
                    case typeEntree:
                        //genererAction(xBloc, yBloc, _type, listPere, listFils,0,0,0,0,0,0);
                        break;
                    case typeGPIO:
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                        }
                        break;

                    case typeAttenteServo:
                        break;
                    case typeAttenteDyna:
                        if(elemBis->Attribute("nom"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("nom"));
                        }
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("angle"));
                            param5 = "0";
                        }
                        if(elemBis->Attribute("load"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("load"));
                            param5 = "1";
                        }

                        param3 = listTimeout;
                        param4 = QString::number(timeOut);

                        break;
                    case typeAttenteTemps:
                        if(elemBis->Attribute("temps"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("temps"));
                        }

                        break;
                    case typeRetourDeplacement:

                        break;
                    case typeRetourOrientation:
                        if(elemBis->Attribute("rotation"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("rotation"));
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("precision"));
                        }
                        param2 = listTimeout;
                        param3 = QString::number(timeOut);
                        //genererAction(xBloc, yBloc, typeRetourOrientation, listPere, listFils,QString::number(orientation),QString::number(precision),listTimeout,QString::number(timeout),0,0);

                        break;
                    case typeRetourPosition:
                        if(elemBis->Attribute("x"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("x"));
                        }
                        if(elemBis->Attribute("y"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("y"));
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("precision"));
                        }
                        param3 = listTimeout;
                        param4 = QString::number(timeOut);
                        //genererAction(xBloc, yBloc, typeRetourPosition, listPere, listFils,QString::number(coordX),QString::number(coordY),QString::number(precision),listTimeout,QString::number(timeout),0);
                        break;
                    case typeRetourGPIO:
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                        }
                        param3 = listTimeout;
                        param2 = QString::number(timeOut);
                        break;
                    case typeAND:
                        param0 = listTimeout;
                        param1 = QString::number(timeOut);
                        break;
                    case typeSetValeur:
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                        }
                        break;
                    case typeDeplacement:
                        if(elemBis->Attribute("id"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("id"));
                        }
                        if(elemBis->Attribute("value"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("value"));
                        }
                        if(elemBis->Attribute("vitesse"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("vitesse"));
                        }
                        param3 = QString::number(timeOut);
                        param4 = listTimeout;
                        break;
                    case typeFin:
                    {
                        break;
                    }
                    case typeCourbe:
                        if(elemBis->Attribute("vitesse"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("vitesse"));
                        }
                        if(elemBis->Attribute("rayon"))
                        {
                            param1 = QString::fromStdString(elemBis->Attribute("rayon"));
                        }
                        if(elemBis->Attribute("angle"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("angle"));
                        }
                        if(elemBis->Attribute("precision"))
                        {
                            param3 = QString::fromStdString(elemBis->Attribute("precision"));
                        }
                        if(elemBis->Attribute("sens"))
                        {
                            param5 = QString::fromStdString(elemBis->Attribute("sens"));
                        }
                        param7 = QString::number(timeOut);
                        param8 = listTimeout;
                        break;

                    case typeAttenteBlocage:
                        if(elemBis->Attribute("sensibilite"))
                        {
                            param2 = QString::fromStdString(elemBis->Attribute("sensibilite"));
                        }
                        param0 = QString::number(timeOut);
                        param1 = listTimeout;
                        break;
                    }
                }else if(elemNameBis == "bloc")
                {
                    if(elemBis->Attribute("x"))
                    {
                        xBloc = atoi(elemBis->Attribute("x"));
                    }
                    if(elemBis->Attribute("y"))
                    {
                        yBloc = atoi(elemBis->Attribute("y"));
                    }
                }
            }
            genererAction(xBloc, yBloc, _type, listPere, listFils,param0,param1,param2,param3,param4,param5,param6,param7,param8);
        }
    }

    emit finParsage();
    return rc;
}

void Sequence::test()
{
    for(int i = 0;i<listAction.size();i++)
    {
        qDebug()<<i<<" "<<listAction.at(i)->getListFils().at(0)->size();
    }
}


