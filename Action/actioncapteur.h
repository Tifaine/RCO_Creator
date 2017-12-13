#ifndef ACTIONCAPTEUR_H
#define ACTIONCAPTEUR_H
#include "action.h"

class ActionCapteur : public Action
{
public:
    ActionCapteur();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
};

#endif // ACTIONCAPTEUR_H
