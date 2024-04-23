import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml 2.12

Window {
    width: 400
    height: 400
    visible: true
    title: qsTr("Hello World")

    Rectangle{
        id: id_main_rect
        anchors.fill: parent
        color: "black"

        Rectangle{
            id: id_small_rect
            width: id_main_rect.width/4
            height: id_main_rect.height/4
            color: "red"
            state: "unshrink"

            MouseArea{
                id: id_small_rect_mouse_area
                property string shrink_state: "unshrink"
                anchors.fill: parent
                drag{
                    target: id_main_rect.state === "edit_on" ? parent : null
                    minimumX: id_main_rect.x * 0.8
                    maximumX: id_main_rect.x + id_main_rect.width - id_small_rect.width
                    minimumY: id_main_rect.y * 0.8
                    maximumY: id_main_rect.y + id_main_rect.height - id_small_rect.height
                }
                onPressAndHold: {
                    id_main_rect.state = "edit_on"
                    id_small_rect.state = "shrink"
                }
                onReleased: {
                    id_main_rect.state = "edit_off"
                    id_small_rect.state = "unshrink"
                }
            }

            states: [
                State {
                    name: "shrink"
                    PropertyChanges{ target: id_small_rect; scale: 0.8}
                },
                State {
                    name: "unshrink"
                    PropertyChanges{ target: id_small_rect; scale: 1.0}
                }
            ]
            transitions: [
                Transition {
                    from: "*"
                    to: "*"
                    PropertyAnimation{ property: "scale"; duration: 300; easing.type: Easing.Linear}
                }
            ]
        }

        state: "edit_off"

        states: [
            State {
                name: "edit_on"
                PropertyChanges{ target: id_main_rect; color: "grey"}
            },
            State {
                name: "edit_off"
                PropertyChanges{ target: id_main_rect; color: "black"}
            }
        ]
    }
}
