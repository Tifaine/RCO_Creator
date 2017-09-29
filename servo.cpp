#include "servo.h"

servo::servo()
{

}

servo::servo(QString _nom, int _id)
{
    nom = _nom;
    id = _id;
}

int servo::getId() const
{
    return id;
}

void servo::setId(int value)
{
    id = value;
}

QString servo::getNom() const
{
    return nom;
}

void servo::setNom(const QString &value)
{
    nom = value;
}

void servo::ajouterValeur(QString nom, int val)
{
    valeur _val;
    _val.nom = nom;
    _val.value = val;
    listValeur.append( &_val);
}
