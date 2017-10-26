#ifndef ACTIONMOTEUR_H
#define ACTIONMOTEUR_H
#include "action.h"

class ActionMoteur : public Action
{
public:
    ActionMoteur();
    void saveXML(QXmlStreamWriter *xmlWriter);
};

#endif // ACTIONMOTEUR_H
