const functions = require('firebase-functions');
const admin = require('firebase-admin');
const now = new Date();

admin.initializeApp();

// 초기화 시간단위 설정
exports.setDefaultValue = functions.pubsub.schedule('0 0 * * *').timeZone('Asia/Seoul').onRun((context) => {
  // Get a database reference
  const database = admin.database();
  // set the start date to the first Sunday of the year
  const startDate = new Date();

  database.ref().set({
    "아주대학교 체육관(2층)": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "나이스짐(24H)": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "M짐(24H)": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "마이짐": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "마이짐 2호점": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "몸빼짐": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "사운드짐": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "석세스짐": [0, 0, 0, 0, 0, 0, 0, 0, 0],
    "휘트니스S": [0, 0, 0, 0, 0, 0, 0, 0, 0]
  });

  // Return a message indicating the function was successfully executed
  console.log('Default value set successfully.');
  return null;
});