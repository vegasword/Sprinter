import { createServer } from  "http";
import * as SQL from "mysql";
import * as SKT from "socket.io";
import { IClientSockets } from "./sockets.interface";

export const DOMAIN = "localhost";
export const SQL_PORT = 3306;
export const SKT_PORT = 3000;
export const CLI_PORT = 5173;

const sql : SQL.Connection = SQL.createConnection({
  host     : DOMAIN,
  port     : SQL_PORT,
  user     : "root",
  password : "root",
  database : "sprinter"
});

sql.connect((error : SQL.MysqlError) => {
  if (error) { console.error("[SQL] " + error.stack); return; }
  sql.query("use sprinter;");
  console.log(`[SQL] Connected on ${sql.config.host}:${sql.config.port} (id: ${sql.threadId})`);
});

const httpServer = createServer();
const io = new SKT.Server(httpServer, {
  cors: {
    origin: "http://" + DOMAIN + ":" + CLI_PORT,
    methods: ["GET", "POST"],
  }
});

io.on("connection", (socket : SKT.Socket) => {  
  socket.on("user:signin", (email : string, password : string) => {
    sql.query({
      sql : "SELECT * FROM user AS u WHERE u.email = ? and u.password = ?",
      values : [email, password]
    }, (error : SQL.MysqlError, results : Array<any>) => {
      if (error) { console.error("[SQL] " + error.stack); return; }        
      if (results[0] !== undefined && results.length === 1) {
        const user = results[0];
        socket.emit("user:signin:success", user);
        console.log(`[SQL] ${user.first_name} ${user.last_name} (${user.email}) is connected`);
      }
    });
  });

  socket.on("teacher:addSprint", (data : IClientSockets.Teacher.AddSprint) => {
    //TODO(a.perche): Check if it's a teacher (LATER: or an admin)
    sql.query({
      sql : "INSERT INTO sprint (name, start, end, classroom_id, teacher_id) values (?,?,?,?,?)",
      values : [data.name, data.start, data.end, data.classroom_id, data.teacher_id]
    }, (error : SQL.MysqlError/*, results : Array<any>*/) => {
      if (error) { console.error("[SQL] " + error.stack); return; }        
    });
  });
})

httpServer.listen(SKT_PORT, 
  () => console.log(`[Socket.IO] Connected on port ${SKT_PORT}`));
