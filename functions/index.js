const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { onDocumentWritten } = require("firebase-functions/v2/firestore");
const { FieldValue, Timestamp } = require("firebase-admin/firestore");

admin.initializeApp();

const firestore = admin.firestore();

exports.accountCreate = functions.auth.user().onCreate((user) => {
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
  return;
});

exports.onExpenseCollectionChanges = onDocumentWritten(
  "users/{uid}/accounts/{accountId}/expenses/{expenseId}",
  (event) => {
    const isDocDeleted = !event.data.after.exists;
    if (isDocDeleted) {
      const docBefore = event.data.before.data();
      const expenseDate = Intl.DateTimeFormat("fr-CA", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        timeZone: "Europe/Bucharest",
      }).format(docBefore.date.toDate());
      const filterDate = new Date(expenseDate);
      filterDate.setDate(27);
      firestore
        .doc(
          `users/${event.params.uid}/accounts/${
            event.params.accountId
          }/expenses_chart/${expenseDate.slice(0, 7)}`
        )
        .set(
          {
            total: FieldValue.increment(docBefore.amount),
            filterDate: filterDate,
          },
          { merge: true }
        );
      return;
    }
    const docAfter = event.data.after.data();
    const expenseDate = Intl.DateTimeFormat("fr-CA", {
      year: "numeric",
      month: "2-digit",
      day: "2-digit",
      timeZone: "Europe/Bucharest",
    }).format(docAfter.date.toDate());
    const filterDate = new Date(expenseDate);
    filterDate.setDate(27);
    firestore
      .doc(
        `users/${event.params.uid}/accounts/${
          event.params.accountId
        }/expenses_chart/${expenseDate.slice(0, 7)}`
      )
      .set(
        {
          total: FieldValue.increment(-docAfter.amount),
          filterDate: filterDate,
        },
        { merge: true }
      );
    return;
  }
);

exports.onIncomesCollectionChanges = onDocumentWritten(
  "users/{uid}/accounts/{accountId}/incomes/{incomeId}",
  (event) => {
    const isDocDeleted = !event.data.after.exists;
    if (isDocDeleted) {
      const docBefore = event.data.before.data();
      const incomeDate = Intl.DateTimeFormat("fr-CA", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        timeZone: "Europe/Bucharest",
      }).format(docBefore.date.toDate());
      const filterDate = new Date(incomeDate);
      filterDate.setDate(27);
      firestore
        .doc(
          `users/${event.params.uid}/accounts/${
            event.params.accountId
          }/incomes_chart/${incomeDate.slice(0, 7)}`
        )
        .set(
          {
            total: FieldValue.increment(-docBefore.amount),
            filterDate: filterDate,
          },
          { merge: true }
        );
      return;
    }
    const docAfter = event.data.after.data();
    const incomeDate = Intl.DateTimeFormat("fr-CA", {
      year: "numeric",
      month: "2-digit",
      day: "2-digit",
      timeZone: "Europe/Bucharest",
    }).format(docAfter.date.toDate());
    const filterDate = new Date(incomeDate);
    filterDate.setDate(27);
    firestore
      .doc(
        `users/${event.params.uid}/accounts/${
          event.params.accountId
        }/incomes_chart/${incomeDate.slice(0, 7)}`
      )
      .set(
        {
          total: FieldValue.increment(docAfter.amount),
          filterDate: filterDate,
        },
        { merge: true }
      );
    return;
  }
);
