import "root:/widgets"
import "root:/services"
import "root:/utils"
import "root:/config"
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

Item {
    id: root

    required property int index
    required property var occupied
    required property int groupOffset

    readonly property bool isWorkspace: true // Flag for finding workspace children
    // Unanimated prop for others to use as reference
    readonly property real size: childrenRect.height + (hasWindows ? Appearance.padding.normal : 0)

    readonly property int ws: groupOffset + index + 1
    readonly property bool isOccupied: occupied[ws] ?? false
    readonly property bool hasWindows: isOccupied && BarConfig.workspaces.showWindows

    Layout.preferredWidth: childrenRect.width
    Layout.preferredHeight: size

    StyledText {
        id: indicator

        readonly property string label: BarConfig.workspaces.label || root.ws
        readonly property string occupiedLabel: BarConfig.workspaces.occupiedLabel || label
        readonly property string activeLabel: BarConfig.workspaces.activeLabel || (root.isOccupied ? occupiedLabel : label)

        animate: true
        text: Hyprland.activeWsId === root.ws || root.isOccupied ? String(root.ws) : label
        //text: Hyprland.activeWsId === root.ws ? activeLabel : root.isOccupied ? occupiedLabel : label
        color: BarConfig.workspaces.occupiedBg || root.isOccupied || Hyprland.activeWsId === root.ws ? Colours.palette.m3onSurface : Colours.palette.m3outlineVariant
        horizontalAlignment: StyledText.AlignHCenter
        verticalAlignment: StyledText.AlignVCenter

        width: BarConfig.sizes.innerHeight
        height: BarConfig.sizes.innerHeight
    }

    Loader {
        id: windows

        active: BarConfig.workspaces.showWindows
        asynchronous: true

        anchors.horizontalCenter: indicator.horizontalCenter
        anchors.top: indicator.bottom

        sourceComponent: Column {
            spacing: Appearance.spacing.small

            add: Transition {
                Anim {
                    properties: "scale"
                    from: 0
                    to: 1
                    easing.bezierCurve: Appearance.anim.curves.standardDecel
                }
            }

            Repeater {
                model: ScriptModel {
                    values: Hyprland.clients.filter(c => c.workspace?.id === root.ws)
                }
                //IconImage {
                //    required property Hyprland.Client modelData

                //    source: {
                //        // Use Icons.getAppIcon to get the icon source based on WM_CLASS.
                //        // Provide an empty string as fallback for getAppIcon.
                //        let iconSource = Icons.getAppIcon(modelData.wmClass, "");

                //        // Retain the ?path= resolution logic, as Quickshell.iconPath might return
                //        // strings in that format, similar to tray.qml.
                //        if (iconSource && typeof iconSource === 'string' && iconSource.includes("?path=")) {
                //            const [name, path] = iconSource.split("?path=");
                //            iconSource = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                //        }
                //        return iconSource;
                //    }
                //    width: BarConfig.sizes.innerHeight * 0.7
                //    height: BarConfig.sizes.innerHeight * 0.7

                //    // Keep the debug logging for the final check
                //    Component.onCompleted: {
                //        console.log("Workspace Icon Debug (Final Attempt with Icons.getAppIcon):",
                //            "WM_CLASS:", modelData.wmClass,
                //            "Icons.getAppIcon result:", Icons.getAppIcon(modelData.wmClass, ""),
                //            "Final Icon Source:", source);
                //    }
                //}

                MaterialIcon {
                    required property Hyprland.Client modelData

                    text: Icons.getAppCategoryIcon(modelData.wmClass, "terminal")
                    color: Colours.palette.m3onSurfaceVariant
                }
            }
        }
    }

    Behavior on Layout.preferredWidth {
        Anim {}
    }

    Behavior on Layout.preferredHeight {
        Anim {}
    }

    component Anim: NumberAnimation {
        duration: Appearance.anim.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.standard
    }
}
