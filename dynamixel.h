#ifndef DYNAMIXEL_H
#define DYNAMIXEL_H
#include <QString>
#include <QList>



class dynamixel
{
public:
    dynamixel();

    int getId() const;
    void setId(int value);

    QString getNom() const;
    void setNom(const QString &value);


    QList<QString> listNom;
    QList<int> listValue;

    QList<QString> listNomVitesse;
    QList<int> listValueVitesse;

private:
    int id = -1;
    QString nom = "";

};

#endif // DYNAMIXEL_H
