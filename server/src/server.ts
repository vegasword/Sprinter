import express from "express";
import cors from "cors";
import * as SQL from "mysql";

export const DOMAIN = "localhost";
export const PORT = 3000;
export const SQL_PORT = 3306;

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

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

app.post("/teacher/addSprint", (req, res) => {
  res.status(200).json(req.body);
});

app.listen(PORT, () => {
  console.log(`[express] Connected on port ${PORT}`);
});

/*
server.on("connection", () => {  
  server.on("user:signin", (email : string, password : string) => {
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
    }, (error : SQL.MysqlError, results : Array<any>) => {
      if (error) { console.error("[SQL] " + error.stack); return; }        
    });
  });
})
*/
