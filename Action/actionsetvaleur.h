#ifndef ACTIONSETVALEUR_H
#define ACTIONSETVALEUR_H
#include "action.h"

class ActionSetValeur : public Action
{
    Q_OBJECT
    Q_PROPERTY(int idValeur READ getIdValeur WRITE setIdValeur NOTIFY idValeurChanged)
    Q_PROPERTY(int valueValeur READ getValueValeur WRITE setValueValeur NOTIFY valueValeurChanged)
public:
    ActionSetValeur();

    void saveXML(QXmlStreamWriter* xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getIdValeur() const;
    void setIdValeur(int value);

    int getValueValeur() const;
    void setValueValeur(int value);

signals:
    void idValeurChanged();
    void valueValeurChanged();

private :
    int idValeur = -1;
    int valueValeur = -1;
};

#endif // ACTIONSETVALEUR_H
