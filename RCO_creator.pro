QT += qml quick
QT += xml

CONFIG += c++11

SOURCES += main.cpp \
    Composant/connector.cpp \
    Sequence/sequence.cpp \
    Action/action.cpp \
    Action/actionposition.cpp \
    Action/actionautre.cpp \
    Action/actioncapteur.cpp \
    Action/actiondynamixel.cpp \
    Action/actionmoteur.cpp \
    Action/actionorientation.cpp \
    Action/actionsequence.cpp \
    Action/actionservo.cpp \
    Action/gestion/gestionservo.cpp \
    Action/gestion/servo.cpp \
    Action/gestion/dynamixel.cpp \
    Action/gestion/gestiondynamixel.cpp \
    Action/gestion/gestionsortie.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Composant/connector.h \
    Sequence/sequence.h \
    Action/action.h \
    Action/actionposition.h \
    Action/actionautre.h \
    Action/actioncapteur.h \
    Action/actiondynamixel.h \
    Action/actionmoteur.h \
    Action/actionorientation.h \
    Action/actionsequence.h \
    Action/actionservo.h \
    Action/gestion/gestionservo.h \
    Action/gestion/servo.h \
    Action/gestion/dynamixel.h \
    Action/gestion/gestiondynamixel.h \
    Action/gestion/gestionsortie.h
