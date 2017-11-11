#ifndef ACTIONDEPART_H
#define ACTIONDEPART_H
#include "action.h"

class ActionDepart : public Action
{
public:
    ActionDepart();
    void saveXML(QXmlStreamWriter *xmlWriter);
};

#endif // ACTIONDEPART_H
