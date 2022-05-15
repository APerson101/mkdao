importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCQMF9mWDwsA9OGUJgH20VCS9jXcfpRgTw",
  authDomain: "mkdao-564b7.firebaseapp.com",
  databaseURL: "https://mkdao-564b7-default-rtdb.firebaseio.com",
  projectId: "mkdao-564b7",
  storageBucket: "mkdao-564b7.appspot.com",
  messagingSenderId: "918021967022",
  appId: "1:918021967022:web:cb2d3cbe7b1fe66a04b13f",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});