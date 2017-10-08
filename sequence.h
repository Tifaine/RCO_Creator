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

private:
    QList<Action*> listAction;
};

#endif // SEQUENCE_H
