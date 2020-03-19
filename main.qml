import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: appWin
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true


    SidePane{
        id: sidePane
        menuHeight: appWin.height
        z: 2
    }

    Button {
        text: "biba"
        onClicked: sidePane.itemVisible = !sidePane.itemVisible
    }
}

