const functions = require('firebase-functions');
const admin = require('firebase-admin');
const FieldValue = require('firebase-admin').firestore.FieldValue;
admin.initializeApp();
const db = admin.firestore();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

/*
exports.noteWriteListener =
    functions.firestore.document('notes/{noteID}')
    .onWrite((change, context) => {
        noteData = change.after.exists ? change.after.data() : null;

          // Get an object with the previous document value (for update or delete)
        if(noteData === null)
            oldDocument = change.before.data();
        return admin.firestore().collection('categories')
        .where('username', '==', noteData === null ? oldDocument.username : noteData.username)
        .where('isSmartList', '==', 'true')
        .orderBy('index', 'asc').get().then((snap) => {
            var smartListsID = []
            snap.forEach(doc => {
                smartListsID.push(doc.id)
                console('id: ' + doc.id);
            })

            if (!change.before.exists) {
                    // New document Created : add one to count
                    const newNote = change.after.data();
                    if(newNote.isImportance) {
                        const importanceRef = admin.firestore().collection('categories').doc(smartListsID[1]);
                        db.doc(importanceRef).update({numOfNotes: FieldValue.increment(1)});
                    }
                    if(newNote.isMyDay) {
                        const myDayRef = admin.firestore().collection('categories').doc(smartListsID[0]);
                        db.doc(myDayRef).update({numOfNotes: FieldValue.increment(1)});
                    }
                    if(newNote.dueDate !== null) {
                        const plannedRef = admin.firestore().collection('categories').doc(smartListsID[2]);
                        db.doc(plannedRef).update({numOfNotes: FieldValue.increment(1)});
                    }
                    const docRef = admin.firestore().collection('categories').doc(noteData.category);
                    db.doc(docRef).update({numOfNotes: FieldValue.increment(1)});
                }
            else if (change.before.exists && change.after.exists) {
                    // Updating existing document:
                     const newNote = change.after.data();
                     if(newNote.isImportance) {
                         const importanceRef = admin.firestore().collection('categories').doc(smartListsID[1]);
                         if(newNote.isDone)
                            db.doc(importanceRef).update({numOfNotes: FieldValue.increment(-1)});
                         else
                            db.doc(importanceRef).update({numOfNotes: FieldValue.increment(1)});
                     }
                     if(newNote.isMyDay) {
                         const myDayRef = admin.firestore().collection('categories').doc(smartListsID[0]);
                         if(newNote.isDone)
                             db.doc(myDayRef).update({numOfNotes: FieldValue.increment(-1)});
                         else
                             db.doc(myDayRef).update({numOfNotes: FieldValue.increment(1)});
                     }
                     if(newNote.dueDate !== null) {
                         const plannedRef = admin.firestore().collection('categories').doc(smartListsID[2]);
                         if(newNote.isDone)
                            db.doc(plannedRef).update({numOfNotes: FieldValue.increment(-1)});
                         else
                            db.doc(plannedRef).update({numOfNotes: FieldValue.increment(1)});
                     }
                     const docRef = admin.firestore().collection('categories').doc(noteData.category);
                     if(newNote.isDone)
                        db.doc(docRef).update({numOfNotes: FieldValue.increment(-1)});
                     else
                        db.doc(docRef).update({numOfNotes: FieldValue.increment(1)});
                }
            else if (!change.after.exists) {
                    // Deleting document : subtract one from count
                    const oldNote = change.before.data()
                    if(oldNote.isImportance) {
                        const importanceRef = admin.firestore().collection('categories').doc(smartListsID[1]);
                        db.doc(importanceRef).update({numOfNotes: FieldValue.increment(-1)});
                    }
                    if(oldNote.isMyDay) {
                        const myDayRef = admin.firestore().collection('categories').doc(smartListsID[0]);
                        db.doc(myDayRef).update({numOfNotes: FieldValue.increment(-1)});
                    }
                    if(oldNote.dueDate !== null) {
                        const plannedRef = admin.firestore().collection('categories').doc(smartListsID[2]);
                        db.doc(plannedRef).update({numOfNotes: FieldValue.increment(-1)});
                    }
                    const docRef = admin.firestore().collection('categories').doc(noteData.category);
                    db.doc(docRef).update({numOfNotes: FieldValue.increment(-1)});
                }
        })
        .catch(err => console.log(err) );
    });
*/
