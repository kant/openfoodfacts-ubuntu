import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem

Page {
    id: history

    header: PageHeader {
        title: i18n.tr("Historical");
       StyleHints {
           foregroundColor: openFoodFacts.settings.fontColor;
           backgroundColor: openFoodFacts.settings.color;
       }

   }
    Component.onCompleted: openFoodFacts.currentPage="History";
    Rectangle {
        id:main
        anchors {
            fill: parent
            topMargin: units.gu(6)
        }
        color: if (openFoodFacts.settings.color == "#3B3B3B"){ "#5D5D5D"; }else{ "#EDEDEC"; }

        Flickable {
            id: flickable
            anchors.fill: parent
            contentHeight: historyColumn.height
            flickableDirection: Flickable.VerticalFlick
            clip: true
            Component.onCompleted: {
                if (openFoodFacts.historyModel.count == "0")
                    emptyrect.visible = true
                else
                    historyColumn.visible = true;
            }




            Rectangle {
                id:emptyrect
                visible: false

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                anchors.topMargin: units.gu(5);
                color: "#EDEDEC"

                Item {
                    id: emptyState
                    anchors.fill: parent;

                    Icon {
                        id: emptyIcon
                        name: "browser-timeline"
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: units.gu(10)
                        width: height
                        color: "#BBBBBB"
                    }

                    Label {
                        id: emptyLabel
                        text: i18n.tr("Empty history")
                        color: "#5d5d5d"
                        fontSize: "large"
                        font.bold: true
                        width: historyColumn.width
                        wrapMode: Text.WordWrap
                        anchors.top: emptyIcon.bottom
                        anchors.topMargin: units.gu(4)
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Label {
                        id: emptySublabel
                        text: i18n.tr("You have not scanned product.")
                        color: "#7b7b7b"
                        width: historyColumn.width
                        wrapMode: Text.WordWrap
                        anchors.top: emptyLabel.bottom
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }

            Column {
                id: historyColumn
                anchors.fill: parent
                anchors.topMargin: units.gu(1)
                visible: false


                ListView {
                    id:historyListView
                    anchors.fill: parent;
                    model: openFoodFacts.historyModel
                    delegate:  ListItem.Subtitled {
                        removable: true
                        confirmRemoval : true
                        onItemRemoved: openFoodFacts.historyModel.remove(index)
                        showDivider: false
                        progression: true
                        Text {
                            width: parent.width
                            horizontalAlignment: Text.AlignLeft
                            color: openFoodFacts.settings.textColor
                            text: label
                        }
                        subText: codebarre
                        onClicked: {
                            var barcodeValue = codebarre;
                            pageStack.push(Qt.resolvedUrl("qrc:///qml/ProductView.qml"), {"barcode": barcodeValue});

                        }
                    }
                }

            } // Column
            
            

            
            
            
        } // Flickable
    }
}
