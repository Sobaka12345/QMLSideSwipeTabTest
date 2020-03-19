
import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 2.12

Item {
    id: screenItem
    anchors.fill: parent

    property int animationDuration: 200
    property bool itemVisible: false
    property bool menuVisible: false
    property int dragThreshold: 120
    property int menuHeight: 300
    property int menuRadius : 15
    property double k: 0.90

    visible: itemVisible
    Rectangle {
        id: rect
        height: menuHeight
        width: parent.width
        x: 0
        y: rect.height * k
        radius: menuRadius
        color: "lightsteelblue"
        Drag.active: menuDragArea.drag.active
        Button {
           id : exit
           contentItem: Text {
                font.pixelSize: 18
                font.bold: true
                text:"❌"
                color: exit.down ? "#F5F5F5" : "#FFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            background: null
            x : rect.width * 0.85
            y : rect.height * 0.01
            onClicked: {
                itemVisible = false
                menuVisible = false
            }
            z:50
        }

        Behavior on y {
            NumberAnimation {
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
        MouseArea {
            property int dragY: 0
            property int startY: 0
            property int diffY: 0

            id: menuDragArea
            hoverEnabled: true
            height: rect.height
            width: rect.width
            anchors.top: rect.top
            drag.target: rect
            drag.axis: Drag.YAxis
            drag.minimumY:0
            drag.maximumY: rect.height * k
            onPressed: startY = rect.y
            onReleased: {
                diffY = Math.abs(startY - rect.y)
                if ((diffY > dragThreshold) && (startY == 0)){
                    rect.y = rect.height * k
                    menuVisible = false
                } else if ((diffY < dragThreshold) && (startY == 0)){
                    rect.y = startY
                    menuVisible = true
                }
                if ((diffY > dragThreshold) && (startY != 0)){
                    rect.y = 0
                    menuVisible = true
                } else if ((diffY < dragThreshold) && (startY != 0)){
                    rect.y = startY
                    menuVisible = false
                }
            }
        }

        Rectangle {
            id: listRect
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * k

            TabBar {
                id: bar
                width: parent.width
                currentIndex: view.currentIndex
                TabButton {
                    text: qsTr("Информация")
                }
                TabButton {
                    text: qsTr("Discover")
                }
                TabButton {
                    text: qsTr("Activity")
                }
            }

            SwipeView {
                id: view
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height - bar.height
                currentIndex: bar.currentIndex

                Text {
                    id: benis1
                }
                Item {
                    id: benis2
                }
                Item {
                    id: benis3
                }
            }

        }
    }


    onMenuVisibleChanged: menuVisible ? rect.y = 0 : rect.y = rect.height * k
}
