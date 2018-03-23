#ifndef ACTIONCOURBE_H
#define ACTIONCOURBE_H

#include "action.h"

class ActionCourbe : public Action
{
    Q_OBJECT
    Q_PROPERTY(int vitesse READ getVitesse WRITE setVitesse NOTIFY vitesseChanged)
    Q_PROPERTY(int rayon READ getRayon WRITE setRayon NOTIFY rayonChanged)
    Q_PROPERTY(int angle READ getAngle WRITE setAngle NOTIFY angleChanged)
    Q_PROPERTY(int precision READ getPrecision WRITE setPrecision NOTIFY precisionChanged)
    Q_PROPERTY(bool sens READ getSens WRITE setSens NOTIFY sensChanged)
public:
    ActionCourbe();

    int getVitesse() const;
    void setVitesse(int value);

    int getRayon() const;
    void setRayon(int value);

    int getAngle() const;
    void setAngle(int value);

    int getPrecision() const;
    void setPrecision(int value);

    bool getSens() const;
    void setSens(bool value);

    void saveXML(QXmlStreamWriter *xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

signals:
    void vitesseChanged();
    void rayonChanged();
    void angleChanged();
    void precisionChanged();
    void sensChanged();

private:
    int vitesse = 0;
    int rayon = 0;
    int angle = 0;
    int precision = 0;
    bool sens = false;
};

#endif // ACTIONCOURBE_H
