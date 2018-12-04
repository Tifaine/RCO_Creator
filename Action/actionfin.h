#ifndef ACTIONFIN_H
#define ACTIONFIN_H
#include "action.h"

class ActionFin : public Action
{
public:
    ActionFin();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
};

#endif // ACTIONFIN_H
