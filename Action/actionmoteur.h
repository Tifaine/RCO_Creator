#ifndef ACTIONMOTEUR_H
#define ACTIONMOTEUR_H
#include "action.h"

class ActionMoteur : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idMoteur READ getIdMoteur WRITE setIdMoteur NOTIFY idMoteurChanged)
    Q_PROPERTY(int valueMoteur READ getValueMoteur WRITE setValueMoteur NOTIFY valueMoteurChanged)
public:
    ActionMoteur();
    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getValueMoteur() const;
    void setValueMoteur(int value);

    int getIdMoteur() const;
    void setIdMoteur(int value);

signals:
    void idMoteurChanged();
    void valueMoteurChanged();

private:
    int idMoteur = -1;
    int valueMoteur = -1;
};

#endif // ACTIONMOTEUR_H
