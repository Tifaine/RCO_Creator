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

int Sequence::ouvrirFichier(QString fileName)
{
    int rc = 0;
    TiXmlDocument doc(fileName.toStdString().c_str());
    if(!doc.LoadFile())
    {
        qDebug()<<fileName+" Fichier introuvable";
        return -1;
    }else
    {
        TiXmlElement* root = doc.FirstChildElement();
        root = root->NextSiblingElement();
        for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
        {
            std::string elemName = elem->Value();
            if(elemName == "Action")
            {
                int id;
                int xBloc;
                int yBloc;
                int timeout;//timeOut
                QString listFils;
                QString listPere;
                QString listTimeout;
                for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
                {
                    std::string elemNameBis = elemBis->Value();

                    if(elemNameBis == "ActionNumero")
                    {
                        TiXmlNode* e = elemBis->FirstChild();
                        if(e!=NULL)
                        {
                            TiXmlText* text = e->ToText();
                            std::string s = text->Value();
                            id = QString::fromStdString(s).toInt();
                        }
                    }else if(elemNameBis == "xBloc")
                    {
                        TiXmlNode* e = elemBis->FirstChild();
                        if(e!=NULL)
                        {
                            TiXmlText* text = e->ToText();
                            std::string s = text->Value();
                            xBloc = QString::fromStdString(s).toInt();
                        }
                    }else if(elemNameBis == "yBloc")
                    {
                        TiXmlNode* e = elemBis->FirstChild();
                        if(e!=NULL)
                        {
                            TiXmlText* text = e->ToText();
                            std::string s = text->Value();
                            yBloc = QString::fromStdString(s).toInt();
                        }
                    }else if(elemNameBis == "timeOut")
                    {
                        TiXmlNode* e = elemBis->FirstChild();
                        if(e!=NULL)
                        {
                            TiXmlText* text = e->ToText();
                            std::string s = text->Value();
                            timeout = QString::fromStdString(s).toInt();
                        }
                    }else if(elemNameBis == "ListFils")
                    {
                        TiXmlNode* e = elemBis->FirstChild();

                        if(e!=NULL)
                        {
                            TiXmlText* text = e->ToText();
                            std::string s = text->Value();
                            listFils = QString::fromStdString(s);
                        }

                    }else if(elemNameBis == "ListPere")
                    {
                        TiXmlNode* e = elemBis->FirstChild();

                        if(e!=NULL)
                        {
                            TiXmlText* text = e->ToText();
                            std::string s = text->Value();
                            listPere = QString::fromStdString(s);
                        }
                    }else if(elemNameBis == "ListTimeOut")
                    {
                        TiXmlNode* e = elemBis->FirstChild();

                        if(e!=NULL)
                        {
                            TiXmlText* text = e->ToText();
                            std::string s = text->Value();
                            listTimeout = QString::fromStdString(s);
                        }
                    }else if(elemNameBis == "actionDepart")
                    {
                        genererAction(xBloc, yBloc, typeEntree, listPere, listFils,0,0,0,0,0,0);
                        /* ActionDepart* actionDepart = new ActionDepart(eave);
                        actionDepart->copie(action,actionDepart);
                        rc = actionDepart->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionDepart->getValideParsage() == VALIDE_PARSE_ACTION_DEPART)
                        {
                            robot->addAction(actionDepart);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionDeplacement")
                    {
                        genererAction(xBloc, yBloc, typeMoteur, listPere, listFils,0,0,0,0,0,0);
                        /* ActionDeplacement* actionDeplacement = new ActionDeplacement(eave);
                        actionDeplacement->copie(action,actionDeplacement);
                        rc = actionDeplacement->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionDeplacement->getValideParsage() == VALIDE_PARSE_ACTION_DEPLACEMNT)
                        {
                            robot->addAction(actionDeplacement);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionDyna")
                    {
                        QString nomDyna;
                        int idDyna=-1;
                        int angleDyna=-1;
                        int vitesseDyna=-1;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();
                            if(elemNameTer == "nomDyna")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    nomDyna = QString::fromStdString(s);

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "idDyna")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    idDyna = QString::fromStdString(s).toInt();
                                    /*reference = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "angle")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    angleDyna = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "vitesse")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    vitesseDyna = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }
                        }

                        if(idDyna != -1 && angleDyna != -1 && vitesseDyna != -1)
                        {
                            genererAction(xBloc, yBloc, typeDyna, listPere, listFils,QString::number(idDyna),QString::number(angleDyna),QString::number(vitesseDyna),nomDyna,0,0);

                        }else
                        {
                            qDebug()<<"Erreur parsage dyna";
                            return -1;
                        }
                        /* ActionDyna* actionDyna = new ActionDyna(eave);
                        actionDyna->copie(action,actionDyna);
                        rc = actionDyna->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionDyna->getValideParsage() == VALIDE_PARSE_ACTION_DYNA)
                        {
                            robot->addAction(actionDyna);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionGpio")
                    {
                        genererAction(xBloc, yBloc, typeGPIO, listPere, listFils,0,0,0,0,0,0);
                        /* ActionGpio* actionGpio = new ActionGpio(eave);
                        actionGpio->copie(action,actionGpio);
                        rc = actionGpio->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionGpio->getValideParsage() == VALIDE_PARSE_ACTION_GPIO)
                        {
                            robot->addAction(actionGpio);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionMetier")
                    {
                        genererAction(xBloc, yBloc, typeAutre, listPere, listFils,0,0,0,0,0,0);
                        /*ActionMetier* actionMetier = new ActionMetier(eave);
                        actionMetier->copie(action,actionMetier);
                        rc = actionMetier->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionMetier->getValideParsage() == VALIDE_PARSE_ACTION_METIER)
                        {
                            robot->addAction(actionMetier);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionPause")
                    {

                        int attente = -1;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();
                            if(elemNameTer == "valueAttente")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    attente = QString::fromStdString(s).toInt();

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }
                        }

                        if(attente != -1)
                        {
                            genererAction(xBloc, yBloc, typeAttenteTemps, listPere, listFils,QString::number(attente),0,0,0,0,0);
                        }else
                        {
                            qDebug()<<"Erreur parsage rotation";
                            return -1;
                        }
                        /*  ActionPause* actionPause = new ActionPause(eave);
                        actionPause->copie(action,actionPause);
                        rc = actionPause->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionPause->getValideParsage() == VALIDE_PARSE_ACTION_PAUSE)
                        {
                            robot->addAction(actionPause);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionPosition")
                    {
                        int posX=-1;
                        int posY=-1;
                        int vitesseRobot=-1;
                        int acc=-1;
                        int dec=-1;
                        int sens=-1;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();

                            if(elemNameTer == "coordX")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    posX = QString::fromStdString(s).toInt();

                                    /*nom = (char*)realloc(nom,s.length());
                                nom = strdup(s.c_str());
                                valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "coordY")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    posY = QString::fromStdString(s).toInt();
                                    /*reference = atoi(s.c_str());
                                valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "vitesse")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    vitesseRobot = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "acc")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    acc = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "dec")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    dec = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "sens")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    sens = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                valideParseElement();*/
                                }
                                else return -1;
                            }


                        }
                        if(posX != -1 && posY != -1 && vitesseRobot != -1)
                        {
                            //genererAction(xBloc, yBloc, typeAttenteTemps, listPere, listFils,0,0,0,0,0,0);

                            genererAction(xBloc, yBloc, typePosition, listPere, listFils,QString::number(posX),QString::number(posY),QString::number(vitesseRobot),QString::number(acc),QString::number(dec),QString::number(sens));

                        }else
                        {
                            qDebug()<<"Erreur parsage position"<<posX<<" "<<posY<<" "<<vitesseRobot;
                            return -1;
                        }
                    }else if(elemNameBis == "actionRetourDeplacement")
                    {
                        genererAction(xBloc, yBloc, typeRetourDeplacement, listPere, listFils,0,0,0,0,0,0);
                        /*ActionRetourDeplacement* actionRetourDeplacement = new ActionRetourDeplacement(eave);
                        actionRetourDeplacement->copie(action,actionRetourDeplacement);
                        rc = actionRetourDeplacement->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionRetourDeplacement->getValideParsage() == VALIDE_PARSE_ACTION_RETOUR_DEPLACEMENT)
                        {
                            robot->addAction(actionRetourDeplacement);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionRetourDyna")
                    {

                        QString nomDyna;
                        int idDyna=-1;
                        int retourAngle=-1;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();
                            if(elemNameTer == "nomDyna")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    nomDyna = QString::fromStdString(s);

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "idDyna")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    idDyna = QString::fromStdString(s).toInt();
                                    /*reference = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "retourAngle")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    retourAngle = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }
                        }

                        if(idDyna != -1 && retourAngle != -1)
                        {
                            genererAction(xBloc, yBloc, typeAttenteDyna, listPere, listFils,QString::number(idDyna),QString::number(retourAngle),nomDyna,listTimeout,QString::number(timeout),0);
                        }else
                        {
                            qDebug()<<"Erreur parsage retour dyna";
                            return -1;
                        }
                    }else if(elemNameBis == "actionRetourGpio")
                    {
                        genererAction(xBloc, yBloc, typeRetourGPIO, listPere, listFils,0,0,0,0,0,0);

                        /* ActionRetourGpio* actionRetourGpio = new ActionRetourGpio(eave);
                        actionRetourGpio->copie(action,actionRetourGpio);
                        rc = actionRetourGpio->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionRetourGpio->getValideParsage() == VALIDE_PARSE_ACTION_RETOUR_GPIO)
                        {
                            robot->addAction(actionRetourGpio);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionRetourPosition")
                    {
                        int coordX=-1;
                        int coordY=-1;
                        int precision=-1;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();
                            if(elemNameTer == "coordX")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    coordX = QString::fromStdString(s).toInt();

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "coordY")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    coordY = QString::fromStdString(s).toInt();
                                    /*reference = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "precision")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    precision = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }
                        }

                        if(coordX != -1 && coordY != -1 && precision != -1)
                        {
                            genererAction(xBloc, yBloc, typeRetourPosition, listPere, listFils,QString::number(coordX),QString::number(coordY),QString::number(precision),listTimeout,QString::number(timeout),0);
                        }else
                        {
                            qDebug()<<"Erreur parsage retour position";
                            return -1;
                        }
                        /*ActionRetourPosition* actionRetourPosition = new ActionRetourPosition(eave);
                        actionRetourPosition->copie(action,actionRetourPosition);
                        rc = actionRetourPosition->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionRetourPosition->getValideParsage() == VALIDE_PARSE_ACTION_RETOUR_POSITION)
                        {
                            robot->addAction(actionRetourPosition);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionRetourRotation")
                    {

                        int orientation = -400;
                        int precision = -1;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();
                            if(elemNameTer == "rotation")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    orientation = QString::fromStdString(s).toInt();

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "precision")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    precision = QString::fromStdString(s).toInt();

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }
                        }

                        if(orientation != -400 && precision != -1)
                        {
                            genererAction(xBloc, yBloc, typeRetourOrientation, listPere, listFils,QString::number(orientation),QString::number(precision),listTimeout,QString::number(timeout),0,0);
                        }else
                        {
                            qDebug()<<"Erreur parsage retour orientation";
                            return -1;
                        }
                        /* ActionRetourRotation* actionRetourRotation = new ActionRetourRotation(eave);
                        actionRetourRotation->copie(action,actionRetourRotation);
                        rc = actionRetourRotation->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionRetourRotation->getValideParsage() == VALIDE_PARSE_ACTION_RETOUR_ROTATION)
                        {
                            robot->addAction(actionRetourRotation);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionRotation")
                    {

                        int orientation = -400;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();
                            if(elemNameTer == "orientation")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    orientation = QString::fromStdString(s).toInt();

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }
                        }

                        if(orientation != -400)
                        {
                            genererAction(xBloc, yBloc, typeOrientation, listPere, listFils,QString::number(orientation),0,0,0,0,0);
                        }else
                        {
                            qDebug()<<"Erreur parsage rotation";
                            return -1;
                        }

                        /* ActionRotation* actionRotation = new ActionRotation(eave);
                        actionRotation->copie(action,actionRotation);
                        rc = actionRotation->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionRotation->getValideParsage() == VALIDE_PARSE_ACTION_ROTATION)
                        {
                            robot->addAction(actionRotation);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionServo")
                    {

                        QString nomServo;
                        int idServo=-1;
                        int valueServo=-1;

                        for(TiXmlElement* elemTer = elemBis->FirstChildElement(); elemTer != NULL; elemTer = elemTer->NextSiblingElement())
                        {
                            std::string elemNameTer = elemTer->Value();
                            if(elemNameTer == "nomServo")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    nomServo = QString::fromStdString(s);

                                    /*nom = (char*)realloc(nom,s.length());
                                    nom = strdup(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "idServo")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    idServo = QString::fromStdString(s).toInt();
                                    /*reference = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }else if(elemNameTer == "angle")
                            {
                                TiXmlNode* e = elemTer->FirstChild();
                                if(e!=NULL)
                                {
                                    TiXmlText* text = e->ToText();
                                    std::string s = text->Value();
                                    valueServo = QString::fromStdString(s).toInt();
                                    /*value = atoi(s.c_str());
                                    valideParseElement();*/
                                }
                                else return -1;
                            }
                        }

                        if(idServo != -1 && valueServo != -1)
                        {
                            genererAction(xBloc, yBloc, typeServo, listPere, listFils,QString::number(idServo),QString::number(valueServo),nomServo,0,0,0);
                        }else
                        {
                            qDebug()<<"Erreur parsage Servo";
                            return -1;
                        }

                        /* ActionServo* actionServo = new ActionServo(eave);
                        actionServo->copie(action,actionServo);
                        rc = actionServo->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionServo->getValideParsage() == VALIDE_PARSE_ACTION_SERVO)
                        {
                            robot->addAction(actionServo);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }
                }
            }
        }
    }
    finParsage();
    return rc;
}
