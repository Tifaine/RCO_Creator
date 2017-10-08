#ifndef ACTION_H
#define ACTION_H
#include <QObject>
#include <QList>
#include <QQuickItem>

class Action : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int typeAction READ getTypeAction WRITE setTypeAction NOTIFY typeActionChanged)
    Q_PROPERTY(bool blocant READ getBlocant WRITE setBlocant NOTIFY blocantChanged)

public:
    Action();

    void setTypeAction(int value);

    void setBlocant(bool value);

    bool getBlocant() const;
    int getTypeAction() const;

    virtual void toString() = 0;

signals:
    void typeActionChanged();
    void blocantChanged();

public slots:

private:
    int typeAction = 0;
    bool blocant;

};

#endif // ACTION_H
