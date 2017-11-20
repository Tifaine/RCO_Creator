#include "xmlmanager.h"


XMLManager::XMLManager(QObject *parent) : QObject(parent)
{

}

QString XMLManager::getNomXmlFile() const
{
    return nomXmlFile;
}

void XMLManager::setNomXmlFile(const QString &value)
{
    nomXmlFile = value;
}

int XMLManager::parseFile(void)
{
    int rc = 0;
    TiXmlDocument doc(nomXmlFile.toStdString().c_str());
    if(!doc.LoadFile())
    {
        qDebug()<<"Fichier introuvable";
        return -1;
    }else
    {
        TiXmlElement* root = doc.FirstChildElement();
        for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
        {
            std::string elemName = elem->Value();
            if(elemName == "Action")
            {
                int id;
                int xBloc;
                int yBloc;
                qDebug()<<"--------- ------------ -------";
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
                    }else if(elemNameBis == "ListFils")
                    {




                    }else if(elemNameBis == "ListPere")
                    {

                    }else if(elemNameBis == "ListTimeOut")
                    {

                    }else if(elemNameBis == "actionDepart")
                    {
                        //genererAction(xBloc, yBloc, typeEntree);
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
                        genererAction(xBloc, yBloc, typeMoteur);
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
                        genererAction(xBloc, yBloc, typeDyna);
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
                        genererAction(xBloc, yBloc, typeGPIO);
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
                        genererAction(xBloc, yBloc, typeAutre);
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
                        genererAction(xBloc, yBloc, typeAttenteTemps);
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
                        genererAction(xBloc, yBloc, typePosition);
                        /*  ActionPosition* actionPosition = new ActionPosition(eave);
                        actionPosition->copie(action,actionPosition);
                        rc = actionPosition->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionPosition->getValideParsage() == VALIDE_PARSE_ACTION_POSITION)
                        {
                            robot->addAction(actionPosition);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionRetourDeplacement")
                    {
                        genererAction(xBloc, yBloc, typeRetourDeplacement);
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
                        genererAction(xBloc, yBloc, typeAttenteDyna);
                        /*ActionRetourDyna* actionRetourDyna = new ActionRetourDyna(eave);
                        actionRetourDyna->copie(action,actionRetourDyna);
                        rc = actionRetourDyna->xmlAutoParse(elemBis);
                        if(rc != EAVE_ERR_SUCCESS) eaveLogPrintf(eave,EAVE_LOG_WARNING,"Valeur manquante au parsage XML de : id:%d:element:%s",action->getId(),elemNameBis.c_str());
                        if(actionRetourDyna->getValideParsage() == VALIDE_PARSE_ACTION_RETOUR_DYNA)
                        {
                            robot->addAction(actionRetourDyna);
                        }
                        else
                        {
                            eaveLogPrintf(eave,EAVE_LOG_ERR,"Impossible d'ajouter l'action [id : %d] a la liste d'action, nombre d'argument invalide",action->getId());
                        }*/
                    }else if(elemNameBis == "actionRetourGpio")
                    {
                        genererAction(xBloc, yBloc, typeRetourGPIO);
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
                        genererAction(xBloc, yBloc, typeRetourPosition);
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
                        genererAction(xBloc, yBloc, typeRetourOrientation);
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
                        genererAction(xBloc, yBloc, typeOrientation);
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
                        genererAction(xBloc, yBloc, typeServo);
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

    return rc;
}
