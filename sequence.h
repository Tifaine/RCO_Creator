#ifndef SEQUENCE_H
#define SEQUENCE_H

#include <QQuickItem>
#include <action.h>

class Sequence : public QQuickItem
{
    Q_OBJECT
public:
    Sequence();


signals:

public slots:
    void addAction(Action* toBeAdded);
    void supprAction(Action* toBeDeletted);
    void parcoursAction();

private:
    QList<Action*> listAction;
};

#endif // SEQUENCE_H
