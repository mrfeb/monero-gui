// Copyright (c) 2014-2015, The Monero Project
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
// 
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import QtQuick 2.0
import "../components"

Rectangle {
    signal paymentClicked(string address, string paymentId, double amount, double fee, int privacyLevel)

    color: "#F0EEEE"


    Label {
        id: amountLabel
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 17
        text: qsTr("Amount")
        fontSize: 14
    }

    Label {
        id: transactionPriority
        anchors.top: parent.top
        anchors.topMargin: 17
        fontSize: 14
        x: (parent.width - 17) / 2 + 17
        text: qsTr("Transaction prority")
    }

    Row {
        anchors.top: amountLabel.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 7
        width: (parent.width - 17) / 2 + 10
        Item {
            width: 37
            height: 37

            Image {
                anchors.centerIn: parent
                source: "../images/moneroIcon.png"
            }
        }
        // Amount input
        LineEdit {
            id: amountLine
            placeholderText: qsTr("Amount...")
            width: parent.width - 37 - 17
        }
    }

    ListModel {
        id: priorityModel
        ListElement { column1: "LOW"; column2: "( fee: 0.0002 )" }
        ListElement { column1: "MEDIUM"; column2: "( fee: 0.0004 )" }
        ListElement { column1: "HIGH"; column2: "( fee: 0.0008 )" }
    }

    StandardDropdown {
        id: priorityDropdown
        anchors.top: transactionPriority.bottom
        anchors.right: parent.right
        anchors.rightMargin: 17
        anchors.topMargin: 5
        anchors.left: transactionPriority.left
        shadowReleasedColor: "#FF4304"
        shadowPressedColor: "#B32D00"
        releasedColor: "#FF6C3C"
        pressedColor: "#FF4304"
        dataModel: priorityModel
        z: 1
    }

    Label {
        id: privacyLabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: priorityDropdown.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 30
        fontSize: 14
        text: qsTr("Privacy Level")
    }

    PrivacyLevel {
        id: privacyLevelItem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: privacyLabel.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 5
    }

    Label {
        id: addressLabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: privacyLevelItem.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 30
        fontSize: 14
        textFormat: Text.RichText
        text: qsTr("<style type='text/css'>a {text-decoration: none; color: #FF6C3C; font-size: 14px;}</style>\
                    Address <font size='2'>  ( Type in  or select from </font> <a href='#'>Address</a><font size='2'> book )</font>")

        onLinkActivated: appWindow.showPageRequest("AddressBook")
    }
    // recipient address input
    LineEdit {
        id: addressLine
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: addressLabel.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 5
        // validator: RegExpValidator { regExp: /[0-9A-Fa-f]{95}/g }
    }

    Label {
        id: paymentIdLabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: addressLine.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 17
        fontSize: 14
        text: qsTr("Payment ID <font size='2'>( Optional )</font>")
    }

    // payment id input
    LineEdit {
        id: paymentIdLine
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: paymentIdLabel.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 5
        // validator: DoubleValidator { top: 0.0 }
    }

    Label {
        id: descriptionLabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: paymentIdLine.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 17
        fontSize: 14
        text: qsTr("Description <font size='2'>( An optional description that will be saved to the local address book if entered )</font>")
    }

    LineEdit {
        id: descriptionLine
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: descriptionLabel.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.topMargin: 5
    }

    StandardButton {
        id: sendButton
        anchors.left: parent.left
        anchors.top: descriptionLine.bottom
        anchors.leftMargin: 17
        anchors.topMargin: 17
        width: 60
        text: qsTr("SEND")
        shadowReleasedColor: "#FF4304"
        shadowPressedColor: "#B32D00"
        releasedColor: "#FF6C3C"
        pressedColor: "#FF4304"
        onClicked: {
            // do more smart validation

            if (addressLine.text.length > 0 && amountLine.text.length > 0) {
                console.log("paymentClicked")
                paymentClicked(addressLine.text, paymentIdLine.text, amountLine.text, 0.0002, 1)
            }
        }
    }
}
