import QtQuick 2.0
import Ubuntu.Components 0.1
import org.nemomobile.folderlistmodel 1.0

Page {
    id: root
    anchors.margins: units.gu(2)

    FolderListModel {
        id: pageModel
        path: homePath()
    }

    tools: ToolbarActions {
        lock: true
        active: true

        back: Action {
            text: i18n.tr("Up")
            onTriggered: {
                pageModel.path = pageModel.parentPath
                console.log("Up triggered")
            }
            visible: pageModel.path != "/"
        }

        Action {
            text: i18n.tr("Home")
            onTriggered: {
                pageModel.path = pageModel.homePath()
                console.log("Home triggered")
            }
        }
    }

    Column {
        anchors.centerIn: root
        Label {
            text: i18n.tr("No files")
            fontSize: "large"
            visible: folderListView.count == 0 && !pageModel.awaitingResults
        }
        ActivityIndicator {
            running: pageModel.awaitingResults
            width: units.gu(8)
            height: units.gu(8)
        }
    }

    FolderListView {
        id: folderListView

        folderListModel: pageModel
        anchors.fill: parent
    }
}
