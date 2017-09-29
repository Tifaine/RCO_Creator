#include "dynamixel.h"

dynamixel::dynamixel()
{

}

int dynamixel::getId() const
{
    return id;
}

void dynamixel::setId(int value)
{
    id = value;
}

QString dynamixel::getNom() const
{
    return nom;
}

void dynamixel::setNom(const QString &value)
{
    nom = value;
}


