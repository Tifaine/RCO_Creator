#ifndef ACTIONCAPTEUR_H
#define ACTIONCAPTEUR_H
#include "action.h"

class ActionCapteur : public Action
{
public:
    ActionCapteur();
    void saveXML(QXmlStreamWriter *xmlWriter);

};

#endif // ACTIONCAPTEUR_H
