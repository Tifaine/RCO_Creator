#ifndef ATTENTETEMPS_H
#define ATTENTETEMPS_H
#include "../action.h"

class AttenteTemps : public Action
{
    Q_OBJECT
    Q_PROPERTY(int temps READ getTemps WRITE setTemps NOTIFY tempsChanged)
public:
    AttenteTemps();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);
    int getTemps() const;
    void setTemps(int value);

signals:
    void tempsChanged();

private:
    int temps = 1000;
};

#endif // ATTENTETEMPS_H
