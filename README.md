# Sharing Ledger
## Introduction
This is a final project for ECE564 mobile APP development.We plan to develop an app that could record all kinds of expenses in our life to help us track our financial status. One of the main features in our appis that we could create a sharing ledger used for group activity, where everyone can add their spending in the ledger and finally the app will calculate how much each person should pay. With our app, we don’t need manually spilt the bill after event, which is quite time consuming and error prone.

## App structure
### Overview
FrontEnd: Using Figma to designed the protocol type, and develop all the UI interface using SwiftUI.
BackEnd: Using FireStore DataBase to store all the user information and event information. 
### File struecture
1. **Entrance: SharingLedger/SharingLedgerApp**
The Entrance contains configuration with FireStore Database and Synchronization(update) between different Devices.And Entrance will go into the EntryView(Login View)
2. **Different Views**
All the Views' definitions are defined under SharingLedger/View
3. **Models**
There are 2 models defined in SharingLedger/ViewModels, SharingLedger/Model HelperModel
   - DukeStorageModel: it is a helper model which pulls the Json data from ECE564 server and store the person name, picture into local cache and initialize the StorageModel.
   - StorageModel: it is the main model to store all the local info for ShareLedgerApp.Also, it contains API to communicate with FireStore DataBase.
        StorageModel contains 3 major variables: 
        - PersonInfo: this contains all the person Info.[PersonID: PersonDetail]
        - AllEvents: this contains all the events. [EventID: EventInfo]
        - AllPayments: this contains all the payments. [PaymentID: paymentDetail]
4. **Helpers**
    These includes Error Handlers, Utility functions, Data Formatter, View Input Handlers.

## Functions List:
- **LoginView**
  - This is the first view when opening the ShareLedgerApp. On this page, you can choose yourself to login by just click your name(Or you can choose any one in ECE564 class to login)
- **HomePage**
  - After you choose one person to login, you will go into the HomePage.
    In HomePage, you will see an addEvent Button on the top of View. When you click it, you will go to AddEventView. If there are existing events that you have already joined in, you will see them. 
  - On each event, if you click the picture of students or "+" sign, you will go to AddpeopleView. On each event, if you click the white background, you will go to EventDetailsPage
- **AddEventView**
  - On this page, you can add new Event, give your new event special name and add new participates to your new event. 
  - Watch out, you can not give your event a blank name or add no participates to your new event.
- **AddpeopleView**
  - This View is just like AddEventView, but it is used for existed event under your name. 
  - In this event, you can edit the number of people in this event.
  - If you want to add person, just choose and click "add" button.
  - If you want to delete person, just swipe the row of person and click "delete"
- **EventDetailPage**
  - This page will show you a brief conclusion about this event.
  - Including total expenses and different payments.
  - If you click "Settle", you will go to SettlePage.
  - If you click each payment, you will go to PaymentDetailPage.
  - if you click "New Payment", you will go to NewPaymentPage.
- **SettlePage**
  - This page will shows who should pay/get what amount of money to whoever in the event which is calculated automatically.
  - If you click the name or photo of one person, you can have a further detail about the settlement.
- **PaymentDetailPage**
  - This page will shows the details about this payment including participates, payers, notes.
  - And also you can click "Delete" button to delete this payment.
- **NewPaymentpage**
  - In this page, you can create new payment, including name, catogory, money, payers, participates, notes.

## APP preview
EventList
![Image text](https://github.com/JunFenngZhi/Sharing_Ledger/blob/main/preView_Images/EditEvent.png) 
![Alt text](preView_Images/EditEvent.png)

