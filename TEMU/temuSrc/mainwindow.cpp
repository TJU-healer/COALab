#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPushButton>
#include <QInputDialog>
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    bool * seq = new bool[10];
    bool *isopen = new bool[1];
    *isopen = false;
    ui->sinum->setValue(1);
    ui->hSlider->setValue(1);

    //background
    this->setAutoFillBackground(true);
    QPixmap pixMap(":/b.png");
    QPixmap backMap = pixMap.scaled(1200, 1200).scaled(width(), height(), Qt::IgnoreAspectRatio, Qt::SmoothTransformation);
    QPalette backPalette;
    backPalette.setBrush(QPalette::Background, QBrush(backMap));
    setPalette(backPalette);

    //toolBar
    QAction * run = new QAction("run", this);
    ui->toolBar->addAction(run);
    ui->toolBar->addSeparator();
    QAction * watchPoint = new QAction("watchpoint", this);
    ui->toolBar->addAction(watchPoint);
    ui->toolBar->addSeparator();
    QAction * info = new QAction("info / EXPR", this);
    ui->toolBar->addAction(info);
    ui->toolBar->addSeparator();
    QAction * help = new QAction("help", this);
    ui->toolBar->addAction(help);

    //changeTheIndex
    ui->stackedWidget->setCurrentIndex(0);
    connect(run, &QAction::triggered , [=](){
        ui->stackedWidget->setCurrentIndex(0);
    });
    connect(watchPoint, &QAction::triggered , [=](){
        ui->stackedWidget->setCurrentIndex(1);
    });
    connect(info, &QAction::triggered , [=](){
        ui->stackedWidget->setCurrentIndex(2);
    });

    //run
    ui->startBtn->setIcon(QIcon(":/kaiji.png"));
    ui->startBtn->setIconSize(QSize(40, 40));
    ui->siBtn->setIcon(QIcon(":/bofang.png"));
    ui->siBtn->setIconSize(QSize(40, 40));
    ui->cBtn->setIcon(QIcon(":/kuaijin.png"));
    ui->cBtn->setIconSize(QSize(40, 40));
    ui->closeBtn->setIcon(QIcon(":/tuichu.png"));
    ui->closeBtn->setIconSize(QSize(40, 40));
    ui->qBtn->setIcon(QIcon(":/guanji.png"));
    ui->qBtn->setIconSize(QSize(40, 40));

    bash = new QProcess();

    connect(ui->startBtn, &QPushButton::clicked, [=](){
        if(*isopen) return;
        *isopen = true;
        bash->start("./build/temu");
        bash->waitForReadyRead();
        QByteArray qb = bash->readAllStandardOutput();
        ui->bashout->setText(qb.mid(0, qb.size() - 7).data());
    });

    void (QSpinBox:: * spSignal) (int) = &QSpinBox::valueChanged;
    connect(ui->sinum, spSignal, ui->hSlider, &QSlider::setValue);
    connect(ui->hSlider, &QSlider::valueChanged, ui->sinum, &QSpinBox::setValue);

    connect(ui->siBtn, &QPushButton::clicked, [=]() {
        if(ui->sinum->value() <= 0) {
            QMessageBox::critical(this, "error", "error: 执行步数小于1!");
        } else {
            QString toW = "si ";
            toW.append(QString::number(ui->sinum->value()));
            toW.append("\n");
            bash->write(toW.toLatin1().data());
            bash->waitForReadyRead(50);
            bash->waitForReadyRead(50);
            QByteArray qb = bash->readAllStandardOutput();
            ui->bashout->setText(qb.mid(5, qb.size() - 12).data());
        }
    });

    connect(ui->cBtn, &QPushButton::clicked, [=](){
        bash->write("c\n");
        bash->waitForReadyRead(50);
        bash->waitForReadyRead(50);
        QByteArray qb = bash->readAllStandardOutput();
        ui->bashout->setText(qb.mid(2, qb.size() - 9).data());
    });

    connect(ui->closeBtn, &QPushButton::clicked, [=](){
        close();
    });

    connect(ui->qBtn, &QPushButton::clicked, [=](){
        if(*isopen == 0) return;
        *isopen = false;
        bash->write("q\n");
        ui->bashout->clear();
        ui->infoBrowser->clear();
        ui->listWidget->clear();
        for(int i = 0;i < 10;i++) seq[i] = false;
    });

    //addWatchPoint
    connect(ui->awpBtn, &QPushButton::clicked, [=](){
        QString qs = QInputDialog::getText(this, "watchPoint", "please input the watchPoint");
        if(qs.size() == 0) return;
        QString toW("w ");
        toW.append(qs);
        toW.append("\n");
        bash->write(toW.toLatin1().data());
        bash->waitForReadyRead(50);
        bash->waitForReadyRead(50);
        bash->readAllStandardOutput();
        qs.prepend("        ");
        for(int i = 0;i < 10;i++) {
            if(!seq[i]) {
                seq[i] = true;
                qs.prepend(QString::number(i));
                break;
            }
        }
        qs.prepend("watchpoint:");
        ui->listWidget->addItem(qs);
    });

    connect(ui->dwpBtn, &QPushButton::clicked, [=](){
        if(ui->listWidget->currentRow() < 0) {
            QMessageBox::critical(this, "error", "请选择一个观察点！");
        } else {
            QString toW("d ");
            toW.append(ui->listWidget->item(ui->listWidget->currentRow())->text().mid(11, 1));
            seq[*((ui->listWidget->item(ui->listWidget->currentRow()))->text().mid(11, 1).toLatin1().data()) - '0'] = false;
            toW.append("\n");
            bash->write(toW.toLatin1().data());
            bash->waitForReadyRead(50);
            bash->waitForReadyRead(50);
            bash->readAllStandardOutput();
            ui->listWidget->takeItem(ui->listWidget->currentRow());
        }
    });

    //info / EXPR
    connect(ui->prBtn, &QPushButton::clicked, [=](){
        bash->write("info r\n");
        bash->waitForReadyRead();
        QByteArray qb = bash->readAllStandardOutput();
        ui->infoBrowser->setText(qb.mid(7, qb.size() - 14).data());
    });

    connect(ui->pwBtn, &QPushButton::clicked, [=](){
        bash->write("info w\n");
        bash->waitForReadyRead();
        QByteArray qb = bash->readAllStandardOutput();
        ui->infoBrowser->setText(qb.mid(7, qb.size() - 14).data());
    });

    connect(ui->peBtn, &QPushButton::clicked, [=](){
        QString qs = QInputDialog::getText(this, "EXPR", "please input the EXPR");
        QString toW("p ");
        toW.append(qs);
        toW.append("\n");
        bash->write(toW.toLatin1().data());
        bash->waitForReadyRead(50);
        bash->waitForReadyRead(50);
        QByteArray qb = bash->readAllStandardOutput();
        ui->infoBrowser->setText(qb.mid(toW.size(), qb.size() - toW.size() - 7).data());
    });

    connect(ui->pmBtn, &QPushButton::clicked, [=](){
        QString toW("x ");
        int n = QInputDialog::getInt(this, "N", "please input the range");
        QString qs = QInputDialog::getText(this, "EXPR", "please input the EXPR");
        toW.append(QString::number(n));
        toW.append(" ");
        toW.append(qs);
        toW.append("\n");
        bash->write(toW.toLatin1().data());
        bash->waitForReadyRead(50);
        bash->waitForReadyRead(50);
        QByteArray qb = bash->readAllStandardOutput();
        ui->infoBrowser->setText(qb.mid(toW.size(), qb.size() - toW.size() - 7).data());
    });

    //help
    connect(help, &QAction::triggered, [=](){
        QMessageBox::information(this, "help", "help - Display informations about all supported commands\nc - Continue the execution of the program\nq - Exit TEMU\nsi - Single Step\ninfo - r for print register state\nw for print watchpoint information\np - Expression Evaluation\nx - Scan Memory\nw - Set Watchpoint \nd - Delete Watchpoint");
    });


}

MainWindow::~MainWindow()
{
    delete ui;
}
