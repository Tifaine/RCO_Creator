#ifndef ACTIONDEPLACEMENT_H
#define ACTIONDEPLACEMENT_H
#include "action.h"

class ActionDeplacement : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idValeur READ getIdValeur WRITE setIdValeur NOTIFY idValeurChanged)
    Q_PROPERTY(int valueValeur READ getValueValeur WRITE setValueValeur NOTIFY valueValeurChanged)
    Q_PROPERTY(int vitesse READ getVitesse WRITE setVitesse NOTIFY vitesseChanged)

public:
    ActionDeplacement();
    void saveXML(QXmlStreamWriter* xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getIdValeur() const;
    void setIdValeur(int value);

    int getValueValeur() const;
    void setValueValeur(int value);

    int getVitesse() const;
    void setVitesse(int value);

signals:
    void idValeurChanged();
    void valueValeurChanged();
    void vitesseChanged();

private :
    int idValeur = -1;
    int valueValeur = -1;
    int vitesse = -1;
};

#endif // ACTIONDEPLACEMENT_H
