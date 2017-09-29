#ifndef SERVO_H
#define SERVO_H
#include <QString>
#include <QList>

struct valeur
{
    QString nom;
    int value;
};

class servo
{
public:
    servo();
    servo(QString _nom, int _id);
    int getId() const;
    void setId(int value);

    QString getNom() const;
    void setNom(const QString &value);

    QList<QString> listNom;
    QList<int> listValue;

    void ajouterValeur(QString nom, int val);

private:
    int id=-1;
    QString nom = "";
    QList<valeur*> listValeur;
};

#endif // SERVO_H
