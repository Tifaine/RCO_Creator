#ifndef ATTENTEBLOCAGE_H
#define ATTENTEBLOCAGE_H

#include "../action.h"

class AttenteBlocage : public Action
{
    Q_OBJECT
    Q_PROPERTY(int temps READ getTemps WRITE setTemps NOTIFY tempsChanged)
public:
    AttenteBlocage();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
    int getTemps() const;
    void setTemps(int value);

signals:
    void tempsChanged();

private:
    int temps = 1000;
};

#endif // ATTENTEBLOCAGE_H
