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
        TiXmlElement * numberIn = new TiXmlElement( "numberIn" );
        action->LinkEndChild( numberIn );
        numberIn->SetAttribute("index", listNumberIn.toStdString().c_str());

        QString listNumberOut;
        listNumberOut.clear();
        for(int j=0;j<listAction.at(i)->getListNumberOut().size();j++)
        {
            listNumberOut.append(QString::number(listAction.indexOf(listAction.at(i)->getListNumberOut().at(j))));
        }
        TiXmlElement * numberOut = new TiXmlElement( "numberOut" );
        action->LinkEndChild( numberOut );
        numberOut->SetAttribute("index", listNumberOut.toStdString().c_str());

        listAction.at(i)->saveXML(action,2);
    }
    doc.SaveFile( filename.toStdString().c_str() );
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
                }else if(type == "actionDeplacement")
                {

                }else if(type == "actionDyna")
                {
                    _type = typeDyna;
                }else if(type == "actionGpio")
                {
                    _type = typeGPIO;
                }else if(type == "actionMetier")
                {

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
                }else if(type == "actionRetourGpio")
                {

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
                }else if(type == "actionSetValeur")
                {
                    _type =  typeSetValeur;
                }else if(type == "actionCourbe")
                {
                    _type =  typeCourbe;
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
                        if(elemBis->Attribute("nomSequence"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("nomSequence"));
                        }
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
                        }

                        param3 = listTimeout;
                        param4 = QString::number(timeOut);

                        break;
                    case typeAttenteTemps:
                        if(elemBis->Attribute("valueAttente"))
                        {
                            param0 = QString::fromStdString(elemBis->Attribute("valueAttente"));
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

    //                    if(elemNameBis == "actionDeplacement")
    //                    {
    //                        genererAction(xBloc, yBloc, typeMoteur, listPere, listFils,0,0,0,0,0,0);
    //                        /* ActionDeplacement* actionDeplacement = new ActionDeplacement(eave);
    //                        actionDeplacement->copie(action,actionDeplacement);
    //                        rc = actionDeplacement->xmlAutoParse(elemBis);
    //                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
    //                        if(actionDeplacement->getValideParsage() == VALIDE_PARSE_ACTION_DEPLACEMNT)
    //                        {
    //                            robot->addAction(actionDeplacement);
    //                        }
    //                        else
    //                        {
    //                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
    //                        }*/
    //                    }
    //                    }else if(elemNameBis == "actionGpio")
    //                    {
    //                        genererAction(xBloc, yBloc, typeGPIO, listPere, listFils,0,0,0,0,0,0);
    //                        /* ActionGpio* actionGpio = new ActionGpio(eave);
    //                        actionGpio->copie(action,actionGpio);
    //                        rc = actionGpio->xmlAutoParse(elemBis);
    //                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
    //                        if(actionGpio->getValideParsage() == VALIDE_PARSE_ACTION_GPIO)
    //                        {
    //                            robot->addAction(actionGpio);
    //                        }
    //                        else
    //                        {
    //                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
    //                        }*/
    //                    }else if(elemNameBis == "actionMetier")
    //                    {
    //                        genererAction(xBloc, yBloc, typeAutre, listPere, listFils,0,0,0,0,0,0);
    //                        /*ActionMetier* actionMetier = new ActionMetier(eave);
    //                        actionMetier->copie(action,actionMetier);
    //                        rc = actionMetier->xmlAutoParse(elemBis);
    //                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
    //                        if(actionMetier->getValideParsage() == VALIDE_PARSE_ACTION_METIER)
    //                        {
    //                            robot->addAction(actionMetier);
    //                        }
    //                        else
    //                        {
    //                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
    //                        }*/
    //
    //                    }else if(elemNameBis == "actionRetourDeplacement")
    //                    {
    //                        genererAction(xBloc, yBloc, typeRetourDeplacement, listPere, listFils,0,0,0,0,0,0);
    //                        /*ActionRetourDeplacement* actionRetourDeplacement = new ActionRetourDeplacement(eave);
    //                        actionRetourDeplacement->copie(action,actionRetourDeplacement);
    //                        rc = actionRetourDeplacement->xmlAutoParse(elemBis);
    //                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
    //                        if(actionRetourDeplacement->getValideParsage() == VALIDE_PARSE_ACTION_RETOUR_DEPLACEMENT)
    //                        {
    //                            robot->addAction(actionRetourDeplacement);
    //                        }
    //                        else
    //                        {
    //                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
    //                        }*/
    //                    }
    //                    }else if(elemNameBis == "actionRetourGpio")
    //                    {
    //                        genererAction(xBloc, yBloc, typeRetourGPIO, listPere, listFils,0,0,0,0,0,0);

    //                        /* ActionRetourGpio* actionRetourGpio = new ActionRetourGpio(eave);
    //                        actionRetourGpio->copie(action,actionRetourGpio);
    //                        rc = actionRetourGpio->xmlAutoParse(elemBis);
    //                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
    //                        if(actionRetourGpio->getValideParsage() == VALIDE_PARSE_ACTION_RETOUR_GPIO)
    //                        {
    //                            robot->addAction(actionRetourGpio);
    //                        }
    //                        else
    //                        {
    //                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
    //                        }*/
    //                    }
    //                    }

    //
    //
    //                    }
    //                }
    //            }
    //        }
    //    }
    //    emit finParsage();


    //    return rc;
}

void Sequence::test()
{
    for(int i = 0;i<listAction.size();i++)
    {
        qDebug()<<i<<" "<<listAction.at(i)->getListFils().at(0)->size();
    }
}


