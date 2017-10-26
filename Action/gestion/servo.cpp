#include "servo.h"

Servo::Servo()
{

}

Servo::Servo(QString _nom, int _id)
{
    nom = _nom;
    id = _id;
}

int Servo::getId() const
{
    return id;
}

void Servo::setId(int value)
{
    id = value;
}

QString Servo::getNom() const
{
    return nom;
}

void Servo::setNom(const QString &value)
{
    nom = value;
}

void Servo::ajouterValeur(QString nom, int val)
{
    valeur _val;
    _val.nom = nom;
    _val.value = val;
    listValeur.append( &_val);
}
