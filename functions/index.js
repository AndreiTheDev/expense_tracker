const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

//aranjeaza functia
exports.accountCreate = functions.auth.user().onCreate((user) => {
  admin
    .firestore()
    .collection("users")
    .doc(user.uid)
    .collection("accounts")
    .doc("default")
    .set(
      {
        createdBy: user.uid,
        expenses: 0,
        income: 0,
        id: "default",
        name: "Default Account",
        totalBalance: 0,
        transactions: [],
      },
      { merge: true }
    );
});
