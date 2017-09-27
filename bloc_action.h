#ifndef BLOC_ACTION_H
#define BLOC_ACTION_H

#include <QObject>
#include <QQuickItem>
#include <QList>
#include <QString>

class bloc_Action : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int posX READ getX WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int posY READ getY WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int xDraw READ getXDraw WRITE setXDraw NOTIFY xDrawChanged)
    Q_PROPERTY(int yDraw READ getYDraw WRITE setYDraw NOTIFY yDrawChanged)
    Q_PROPERTY(QString nom_Bloc READ nom_Bloc WRITE setNom_Bloc NOTIFY nom_BlocChanged)

public:
    explicit bloc_Action(QQuickItem *parent = nullptr);

    int getX();
    int getY();

    void setX(int _x);
    void setY(int _y);

    int getXDraw() const;
    void setXDraw(int value);

    int getYDraw() const;
    void setYDraw(int value);
    void setNom_Bloc(QString m_nomBloc);

    QString nom_Bloc();

    QList<bloc_Action *> *getListPere() const;

    QList<bloc_Action *>* getListFils() const;

    void otherHaraKiri(bloc_Action* other);


signals:
    void xChanged();
    void yChanged();
    void xDrawChanged();
    void yDrawChanged();
    void listPereChanged();
    void listFilsChanged();
    void removeFils(int filsIndigne);
    void nom_BlocChanged();



public slots:
    void addFils(bloc_Action* toAdd);
    void addPere(bloc_Action* toAdd);
    bloc_Action* getFils(int indice);
    bloc_Action* getPere(int indice);
    int getNbPere();
    int getNbFils();
    void deleteFils(bloc_Action* toDelete);
    void deletePere(bloc_Action* toDelete);
    void haraKiri();


private:
    int posX = 0;
    int posY = 0;
    int xDraw = 0;
    int yDraw = 0;
    QList<bloc_Action*> * listPere;
    QList<bloc_Action*> * listFils;
    QString nomBloc;
};

#endif // BLOC_ACTION_H
