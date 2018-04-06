#ifndef ATTENTEBLOCAGE_H
#define ATTENTEBLOCAGE_H

#include "../action.h"

class AttenteBlocage : public Action
{
    Q_OBJECT
    //Add sensibilité
    Q_PROPERTY(int sensibilite READ getSensibilite WRITE setSensibilite NOTIFY sensibiliteChanged)

public:
    AttenteBlocage();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
    int getSensibilite() const;
    void setSensibilite(int value);

signals:
    void sensibiliteChanged();

private:
    int sensibilite = 10;
};

#endif // ATTENTEBLOCAGE_H
