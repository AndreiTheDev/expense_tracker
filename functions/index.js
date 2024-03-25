const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

//aranjeaza functia
exports.accountCreate = functions.auth.user().onCreate((user) => {
  const firestore = admin.firestore();
  const batch = firestore.batch();

  const accountsDoc = firestore
    .collection("users")
    .doc(user.uid)
    .collection("accounts")
    .doc("default");

  batch.set(
    accountsDoc,
    {
      createdBy: user.uid,
      expenses: 0,
      income: 0,
      id: "default",
      name: "Default Account",
      totalBalance: 0,
    },
    { merge: true }
  );

  batch.commit();
});
