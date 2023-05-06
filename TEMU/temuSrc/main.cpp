#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.setWindowTitle("TEMU");
    w.setWindowIcon(QIcon(":/1.ico"));
    w.show();
    
    return a.exec();
}
