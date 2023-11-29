import http from "http";
// import WebSocket from "ws";
import SocketIO from "socket.io";
import express from "express";

const app = express();

app.set("view engine", "pug");
app.set("views", __dirname + "/views");
app.use("/public", express.static(__dirname + "/public"));
app.get("/", (_, res) => res.render("home"));
app.get("/*", (_, res) => res.redirect("/"));

const handleListen = () => console.log(`listening on http://localhost:3000`);

// 이전에는 app.listen을 하기 전에 서버에 접근할 수 없었지만, 이제는 접근할 수 있다.
const httpServer = http.createServer(app);
// socket.io 서버를 http 서버 위에 생성
const io = SocketIO(httpServer);

// ws 사용
// http 서버 위에 webSocket 서버를 만들 수 있다.
// http 서버가 반드시 필요한 것은 아니며, ws만으로도 서버를 만들 수 있다.
// const wss = new WebSocket.Server({ server });
// // fake db
// const sockets = [];
// // 여기서의 인자 socket의 의미는 브라우저와 서버와의 연결을 의미한다.
// wss.on("connection", (socket) => {
//   socket.nickname = "Anonymous";
// 	sockets.push(socket);
//   console.log("Connected to Browser✅");
//   socket.on("close", () => {
//     console.log("Disconnected from Browser ❌");
//   });
//   socket.on("message", (msg, isBinary) => {
//     msg = isBinary ? msg : msg.toString();
//     const message = JSON.parse(msg);

//     switch (message.type) {
//       case "new_message":
//         sockets.forEach((aSocket) => {
//           aSocket.send(`${socket.nickname}: ${message.payload}`);
//         });
//       case "nickname":
//         socket["nickname"] = message.payload;
//     }
//   });
// });

io.on("connection", (socket) => {
  socket.on("enter_room", (msg, done) => {
    console.log(msg);
    setTimeout(() => {
      done();
    }, 10000);
  });
});

// 같은 포트에서 http, ws를 처리할 수 있다.
httpServer.listen(3000, handleListen);
