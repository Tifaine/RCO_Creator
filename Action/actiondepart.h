#ifndef ACTIONDEPART_H
#define ACTIONDEPART_H
#include "action.h"

class ActionDepart : public Action
{
public:
    ActionDepart();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
};

#endif // ACTIONDEPART_H
