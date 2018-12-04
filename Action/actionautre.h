#ifndef ACTIONAUTRE_H
#define ACTIONAUTRE_H
#include "action.h"

class ActionAutre : public Action
{
public:
    ActionAutre();

    void saveXML(QXmlStreamWriter* xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
};

#endif // ACTIONAUTRE_H
