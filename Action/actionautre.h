#ifndef ACTIONAUTRE_H
#define ACTIONAUTRE_H
#include "action.h"

class ActionAutre : public Action
{
public:
    ActionAutre();

    void saveXML(QXmlStreamWriter* xmlWriter);
};

#endif // ACTIONAUTRE_H
