/*
 * Light/Dark Mode Toggle Plasmoid for gloam
 * SPDX-License-Identifier: GPL-3.0
 */
import QtQuick
import QtQuick.Controls as QQC2
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property string mode: "light"
    property bool busy: false

    readonly property string readModeCmd:
        "cat \"${XDG_RUNTIME_DIR}/gloam-runtime\" 2>/dev/null || echo light"

    Plasmoid.icon: mode === "auto" ? "contrast"
                 : mode === "dark" ? "weather-clear-night"
                 : "weather-clear"
    toolTipMainText: mode === "auto" ? "Auto Mode" : (mode === "dark" ? "Dark Mode" : "Light Mode")
    toolTipSubText: mode === "auto" ? "Following system day/night schedule" : "Click to switch"

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: "Light Mode"
            icon.name: "weather-clear"
            onTriggered: root.runCommand("gloam light")
        },
        PlasmaCore.Action {
            text: "Dark Mode"
            icon.name: "weather-clear-night"
            onTriggered: root.runCommand("gloam dark")
        },
        PlasmaCore.Action {
            text: "Auto Mode"
            icon.name: "contrast"
            onTriggered: root.runCommand("gloam auto")
        },
        PlasmaCore.Action {
            text: "Toggle"
            icon.name: "system-switch-user"
            onTriggered: root.runCommand("gloam toggle")
        },
        PlasmaCore.Action {
            isSeparator: true
        }
    ]

    Plasmoid.onActivated: runCommand("gloam toggle")

    // Reads the mode from gloam-runtime (tmpfs — negligible I/O)
    Plasma5Support.DataSource {
        id: modeReader
        engine: "executable"
        connectedSources: [root.readModeCmd]
        interval: 1000
        onNewData: (sourceName, data) => {
            var result = data["stdout"].toString().trim()
            if (result)
                root.mode = result
        }
    }

    // Runs gloam commands from plasmoid clicks/actions
    Plasma5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: (sourceName, data) => {
            disconnectSource(sourceName)
            root.busy = false
            // Force immediate re-read after a gloam command
            modeReader.disconnectSource(root.readModeCmd)
            modeReader.connectSource(root.readModeCmd)
        }
    }

    function runCommand(cmd) {
        if (!busy) {
            busy = true
            executable.connectSource(cmd)
        }
    }

    preferredRepresentation: fullRepresentation
    fullRepresentation: MouseArea {
        id: mouseArea

        hoverEnabled: true
        onClicked: root.runCommand("gloam toggle")

        Kirigami.Icon {
            source: root.mode === "auto" ? "contrast"
                  : root.mode === "dark" ? "weather-clear-night"
                  : "weather-clear"
            anchors.fill: parent
            active: mouseArea.containsMouse
            visible: !root.busy
        }

        QQC2.BusyIndicator {
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height) * 0.8
            height: width
            running: root.busy
            visible: root.busy
        }

        PlasmaCore.ToolTipArea {
            anchors.fill: parent
            mainText: root.toolTipMainText
            subText: root.toolTipSubText
        }
    }
}
