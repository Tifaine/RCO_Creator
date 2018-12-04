#include "dynamixel.h"

Dynamixel::Dynamixel()
{

}

int Dynamixel::getId() const
{
    return id;
}

void Dynamixel::setId(int value)
{
    id = value;
}

QString Dynamixel::getNom() const
{
    return nom;
}

void Dynamixel::setNom(const QString &value)
{
    nom = value;
}


