#ifndef SEQUENCE_H
#define SEQUENCE_H

#include <QQuickItem>
#include <QList>
#include "../Action/action.h"

class Sequence : public QQuickItem
{
    Q_OBJECT
public:
    Sequence(QQuickItem *parent = nullptr);

signals:

public slots:
    void ajouterAction(Action* essai);
    void enregistrerSous(QString filename);

private:
    QList<Action*> listAction;
};

#endif // SEQUENCE_H
