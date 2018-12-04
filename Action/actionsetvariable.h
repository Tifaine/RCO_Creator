#ifndef ACTIONSETVARIABLE_H
#define ACTIONSETVARIABLE_H
#include "action.h"

class actionSetVariable : public Action
{
    Q_OBJECT
    Q_PROPERTY(int nomOperation READ getNomOperation WRITE setNomOperation NOTIFY nomOperationChanged)
    Q_PROPERTY(int nomRobot READ getNomRobot WRITE setNomRobot NOTIFY nomRobotChanged)
    Q_PROPERTY(int nomVar READ getNomVar WRITE setNomVar NOTIFY nomVarChanged)
    Q_PROPERTY(double variable READ getVariable WRITE setVariable NOTIFY variableChanged)
public:
    actionSetVariable();
    void saveXML(QXmlStreamWriter* xmlWriter);
    void saveXML(TiXmlElement * root, int indice);

    int getNomVar() const;
    void setNomVar(const int &value);

    int getNomRobot() const;
    void setNomRobot(const int &value);

    int getNomOperation() const;
    void setNomOperation(const int &value);

    double getVariable() const;
    void setVariable(double value);

signals:
    void nomVarChanged();
    void nomRobotChanged();
    void nomOperationChanged();
    void variableChanged();

private:
    int nomVar;
    int nomRobot;
    int nomOperation;
    double variable;
};

#endif // ACTIONSETVARIABLE_H
