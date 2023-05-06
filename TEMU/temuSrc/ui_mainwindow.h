/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.1.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QListWidget>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSlider>
#include <QtWidgets/QSpacerItem>
#include <QtWidgets/QSpinBox>
#include <QtWidgets/QStackedWidget>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QToolButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralWidget;
    QHBoxLayout *horizontalLayout_6;
    QStackedWidget *stackedWidget;
    QWidget *page_3;
    QVBoxLayout *verticalLayout_3;
    QWidget *widget_3;
    QHBoxLayout *horizontalLayout_2;
    QWidget *widget;
    QHBoxLayout *horizontalLayout_7;
    QWidget *widget_9;
    QVBoxLayout *verticalLayout_4;
    QToolButton *startBtn;
    QSpacerItem *verticalSpacer;
    QToolButton *siBtn;
    QWidget *widget_8;
    QVBoxLayout *verticalLayout_7;
    QSpinBox *sinum;
    QSlider *hSlider;
    QSpacerItem *verticalSpacer_2;
    QToolButton *cBtn;
    QSpacerItem *verticalSpacer_3;
    QToolButton *qBtn;
    QSpacerItem *verticalSpacer_4;
    QToolButton *closeBtn;
    QSpacerItem *horizontalSpacer;
    QWidget *widget_2;
    QVBoxLayout *verticalLayout;
    QTextBrowser *bashout;
    QWidget *page_4;
    QHBoxLayout *horizontalLayout_4;
    QWidget *widget_5;
    QHBoxLayout *horizontalLayout;
    QWidget *widget_4;
    QVBoxLayout *verticalLayout_2;
    QPushButton *awpBtn;
    QPushButton *dwpBtn;
    QListWidget *listWidget;
    QWidget *page_5;
    QVBoxLayout *verticalLayout_6;
    QWidget *widget_7;
    QHBoxLayout *horizontalLayout_5;
    QWidget *widget_6;
    QVBoxLayout *verticalLayout_5;
    QPushButton *prBtn;
    QPushButton *pwBtn;
    QPushButton *peBtn;
    QPushButton *pmBtn;
    QTextBrowser *infoBrowser;
    QToolBar *toolBar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QStringLiteral("MainWindow"));
        MainWindow->setWindowModality(Qt::WindowModal);
        MainWindow->resize(810, 627);
        QIcon icon;
        icon.addFile(QStringLiteral(":/icon.jeg"), QSize(), QIcon::Normal, QIcon::Off);
        MainWindow->setWindowIcon(icon);
        MainWindow->setAutoFillBackground(true);
        MainWindow->setStyleSheet(QStringLiteral(""));
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        horizontalLayout_6 = new QHBoxLayout(centralWidget);
        horizontalLayout_6->setSpacing(6);
        horizontalLayout_6->setContentsMargins(11, 11, 11, 11);
        horizontalLayout_6->setObjectName(QStringLiteral("horizontalLayout_6"));
        stackedWidget = new QStackedWidget(centralWidget);
        stackedWidget->setObjectName(QStringLiteral("stackedWidget"));
        page_3 = new QWidget();
        page_3->setObjectName(QStringLiteral("page_3"));
        verticalLayout_3 = new QVBoxLayout(page_3);
        verticalLayout_3->setSpacing(6);
        verticalLayout_3->setContentsMargins(11, 11, 11, 11);
        verticalLayout_3->setObjectName(QStringLiteral("verticalLayout_3"));
        widget_3 = new QWidget(page_3);
        widget_3->setObjectName(QStringLiteral("widget_3"));
        horizontalLayout_2 = new QHBoxLayout(widget_3);
        horizontalLayout_2->setSpacing(6);
        horizontalLayout_2->setContentsMargins(11, 11, 11, 11);
        horizontalLayout_2->setObjectName(QStringLiteral("horizontalLayout_2"));
        widget = new QWidget(widget_3);
        widget->setObjectName(QStringLiteral("widget"));
        horizontalLayout_7 = new QHBoxLayout(widget);
        horizontalLayout_7->setSpacing(6);
        horizontalLayout_7->setContentsMargins(11, 11, 11, 11);
        horizontalLayout_7->setObjectName(QStringLiteral("horizontalLayout_7"));
        widget_9 = new QWidget(widget);
        widget_9->setObjectName(QStringLiteral("widget_9"));
        verticalLayout_4 = new QVBoxLayout(widget_9);
        verticalLayout_4->setSpacing(6);
        verticalLayout_4->setContentsMargins(11, 11, 11, 11);
        verticalLayout_4->setObjectName(QStringLiteral("verticalLayout_4"));
        startBtn = new QToolButton(widget_9);
        startBtn->setObjectName(QStringLiteral("startBtn"));
        startBtn->setMinimumSize(QSize(112, 60));
        startBtn->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);

        verticalLayout_4->addWidget(startBtn);

        verticalSpacer = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout_4->addItem(verticalSpacer);

        siBtn = new QToolButton(widget_9);
        siBtn->setObjectName(QStringLiteral("siBtn"));
        siBtn->setMinimumSize(QSize(112, 60));
        siBtn->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);

        verticalLayout_4->addWidget(siBtn);

        widget_8 = new QWidget(widget_9);
        widget_8->setObjectName(QStringLiteral("widget_8"));
        verticalLayout_7 = new QVBoxLayout(widget_8);
        verticalLayout_7->setSpacing(6);
        verticalLayout_7->setContentsMargins(11, 11, 11, 11);
        verticalLayout_7->setObjectName(QStringLiteral("verticalLayout_7"));
        sinum = new QSpinBox(widget_8);
        sinum->setObjectName(QStringLiteral("sinum"));
        sinum->setMinimumSize(QSize(60, 0));
        sinum->setMaximumSize(QSize(40, 16777215));

        verticalLayout_7->addWidget(sinum);

        hSlider = new QSlider(widget_8);
        hSlider->setObjectName(QStringLiteral("hSlider"));
        QSizePolicy sizePolicy(QSizePolicy::Preferred, QSizePolicy::Fixed);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(hSlider->sizePolicy().hasHeightForWidth());
        hSlider->setSizePolicy(sizePolicy);
        hSlider->setMinimumSize(QSize(100, 0));
        hSlider->setOrientation(Qt::Horizontal);

        verticalLayout_7->addWidget(hSlider);


        verticalLayout_4->addWidget(widget_8);

        verticalSpacer_2 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout_4->addItem(verticalSpacer_2);

        cBtn = new QToolButton(widget_9);
        cBtn->setObjectName(QStringLiteral("cBtn"));
        cBtn->setMinimumSize(QSize(112, 60));
        cBtn->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);

        verticalLayout_4->addWidget(cBtn);

        verticalSpacer_3 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout_4->addItem(verticalSpacer_3);

        qBtn = new QToolButton(widget_9);
        qBtn->setObjectName(QStringLiteral("qBtn"));
        qBtn->setMinimumSize(QSize(112, 60));
        qBtn->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);

        verticalLayout_4->addWidget(qBtn);

        verticalSpacer_4 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout_4->addItem(verticalSpacer_4);

        closeBtn = new QToolButton(widget_9);
        closeBtn->setObjectName(QStringLiteral("closeBtn"));
        closeBtn->setMinimumSize(QSize(112, 60));
        closeBtn->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);

        verticalLayout_4->addWidget(closeBtn);


        horizontalLayout_7->addWidget(widget_9);

        horizontalSpacer = new QSpacerItem(10, 20, QSizePolicy::Preferred, QSizePolicy::Minimum);

        horizontalLayout_7->addItem(horizontalSpacer);

        widget_2 = new QWidget(widget);
        widget_2->setObjectName(QStringLiteral("widget_2"));
        verticalLayout = new QVBoxLayout(widget_2);
        verticalLayout->setSpacing(6);
        verticalLayout->setContentsMargins(11, 11, 11, 11);
        verticalLayout->setObjectName(QStringLiteral("verticalLayout"));
        bashout = new QTextBrowser(widget_2);
        bashout->setObjectName(QStringLiteral("bashout"));

        verticalLayout->addWidget(bashout);


        horizontalLayout_7->addWidget(widget_2);


        horizontalLayout_2->addWidget(widget);


        verticalLayout_3->addWidget(widget_3);

        stackedWidget->addWidget(page_3);
        page_4 = new QWidget();
        page_4->setObjectName(QStringLiteral("page_4"));
        horizontalLayout_4 = new QHBoxLayout(page_4);
        horizontalLayout_4->setSpacing(6);
        horizontalLayout_4->setContentsMargins(11, 11, 11, 11);
        horizontalLayout_4->setObjectName(QStringLiteral("horizontalLayout_4"));
        widget_5 = new QWidget(page_4);
        widget_5->setObjectName(QStringLiteral("widget_5"));
        horizontalLayout = new QHBoxLayout(widget_5);
        horizontalLayout->setSpacing(6);
        horizontalLayout->setContentsMargins(11, 11, 11, 11);
        horizontalLayout->setObjectName(QStringLiteral("horizontalLayout"));
        widget_4 = new QWidget(widget_5);
        widget_4->setObjectName(QStringLiteral("widget_4"));
        verticalLayout_2 = new QVBoxLayout(widget_4);
        verticalLayout_2->setSpacing(6);
        verticalLayout_2->setContentsMargins(11, 11, 11, 11);
        verticalLayout_2->setObjectName(QStringLiteral("verticalLayout_2"));
        awpBtn = new QPushButton(widget_4);
        awpBtn->setObjectName(QStringLiteral("awpBtn"));
        awpBtn->setMinimumSize(QSize(150, 90));
        QFont font;
        font.setPointSize(15);
        awpBtn->setFont(font);

        verticalLayout_2->addWidget(awpBtn);

        dwpBtn = new QPushButton(widget_4);
        dwpBtn->setObjectName(QStringLiteral("dwpBtn"));
        dwpBtn->setMinimumSize(QSize(150, 90));
        dwpBtn->setFont(font);

        verticalLayout_2->addWidget(dwpBtn);


        horizontalLayout->addWidget(widget_4);

        listWidget = new QListWidget(widget_5);
        listWidget->setObjectName(QStringLiteral("listWidget"));

        horizontalLayout->addWidget(listWidget);


        horizontalLayout_4->addWidget(widget_5);

        stackedWidget->addWidget(page_4);
        page_5 = new QWidget();
        page_5->setObjectName(QStringLiteral("page_5"));
        verticalLayout_6 = new QVBoxLayout(page_5);
        verticalLayout_6->setSpacing(6);
        verticalLayout_6->setContentsMargins(11, 11, 11, 11);
        verticalLayout_6->setObjectName(QStringLiteral("verticalLayout_6"));
        widget_7 = new QWidget(page_5);
        widget_7->setObjectName(QStringLiteral("widget_7"));
        horizontalLayout_5 = new QHBoxLayout(widget_7);
        horizontalLayout_5->setSpacing(6);
        horizontalLayout_5->setContentsMargins(11, 11, 11, 11);
        horizontalLayout_5->setObjectName(QStringLiteral("horizontalLayout_5"));
        widget_6 = new QWidget(widget_7);
        widget_6->setObjectName(QStringLiteral("widget_6"));
        verticalLayout_5 = new QVBoxLayout(widget_6);
        verticalLayout_5->setSpacing(6);
        verticalLayout_5->setContentsMargins(11, 11, 11, 11);
        verticalLayout_5->setObjectName(QStringLiteral("verticalLayout_5"));
        prBtn = new QPushButton(widget_6);
        prBtn->setObjectName(QStringLiteral("prBtn"));
        prBtn->setMinimumSize(QSize(150, 90));
        prBtn->setFont(font);

        verticalLayout_5->addWidget(prBtn);

        pwBtn = new QPushButton(widget_6);
        pwBtn->setObjectName(QStringLiteral("pwBtn"));
        pwBtn->setMinimumSize(QSize(150, 90));
        pwBtn->setFont(font);

        verticalLayout_5->addWidget(pwBtn);

        peBtn = new QPushButton(widget_6);
        peBtn->setObjectName(QStringLiteral("peBtn"));
        peBtn->setMinimumSize(QSize(150, 90));
        peBtn->setFont(font);

        verticalLayout_5->addWidget(peBtn);

        pmBtn = new QPushButton(widget_6);
        pmBtn->setObjectName(QStringLiteral("pmBtn"));
        pmBtn->setMinimumSize(QSize(150, 90));
        pmBtn->setFont(font);

        verticalLayout_5->addWidget(pmBtn);


        horizontalLayout_5->addWidget(widget_6);

        infoBrowser = new QTextBrowser(widget_7);
        infoBrowser->setObjectName(QStringLiteral("infoBrowser"));

        horizontalLayout_5->addWidget(infoBrowser);


        verticalLayout_6->addWidget(widget_7);

        stackedWidget->addWidget(page_5);

        horizontalLayout_6->addWidget(stackedWidget);

        MainWindow->setCentralWidget(centralWidget);
        toolBar = new QToolBar(MainWindow);
        toolBar->setObjectName(QStringLiteral("toolBar"));
        toolBar->setMovable(false);
        toolBar->setIconSize(QSize(80, 80));
        MainWindow->addToolBar(Qt::TopToolBarArea, toolBar);

        retranslateUi(MainWindow);

        stackedWidget->setCurrentIndex(0);


        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "MainWindow", 0));
        startBtn->setText(QApplication::translate("MainWindow", "\345\274\200\346\234\272", 0));
        siBtn->setText(QApplication::translate("MainWindow", "\345\215\225\346\255\245\346\211\247\350\241\214", 0));
        cBtn->setText(QApplication::translate("MainWindow", "\347\273\247\347\273\255\350\277\220\350\241\214", 0));
        qBtn->setText(QApplication::translate("MainWindow", "\345\205\263\346\234\272", 0));
        closeBtn->setText(QApplication::translate("MainWindow", "\351\200\200\345\207\272", 0));
        awpBtn->setText(QApplication::translate("MainWindow", "addWatchPoint", 0));
        dwpBtn->setText(QApplication::translate("MainWindow", "delWatchPoint", 0));
        prBtn->setText(QApplication::translate("MainWindow", "printRegister", 0));
        pwBtn->setText(QApplication::translate("MainWindow", "printWatchPoint", 0));
        peBtn->setText(QApplication::translate("MainWindow", "printExpr", 0));
        pmBtn->setText(QApplication::translate("MainWindow", "printMemory", 0));
        toolBar->setWindowTitle(QApplication::translate("MainWindow", "toolBar", 0));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
