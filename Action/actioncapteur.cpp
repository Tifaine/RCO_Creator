#include "actioncapteur.h"

ActionCapteur::ActionCapteur()
{
    setType(typeCapteur);
}

void ActionCapteur::saveXML(QXmlStreamWriter* xmlWriter)
{
    qDebug()<<"Action capteur";
}
