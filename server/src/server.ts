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
  if (error) { 
    console.error("[SQL] " + error.stack); 
    return;
  }
  sql.query("use sprinter;");
  console.log(`[SQL] Connected on ${sql.config.host}:${sql.config.port}`,
              `(id: ${sql.threadId})`);
});

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.listen(PORT, () => { console.log(`[express] Connected on port ${PORT}`);});

///////////////////////////////////////////////////////////////////////////////
// COMMON REQUESTS
///////////////////////////////////////////////////////////////////////////////

app.post("/signin", (req, res) => {
  const data : { email : string, password : string } = req.body;
  
  sql.query({
      sql : "SELECT * FROM user AS u WHERE u.email = ? and u.password = ?",
      values : [data.email, data.password]
    }, (error : SQL.MysqlError, users : Array<any>) => {
      if (error) { 
        console.error("[SQL] " + error.stack);
        res.sendStatus(400);
      } else {
        const user = users[0];
        if (user) {
          console.log(`[SQL] ${req.socket.remoteAddress} connected as`, 
                      `${user.first_name} ${user.last_name} (#${user.id})`);
          res.redirect(`http://${DOMAIN}:5173/src/dashboard.html`);
        } else {
          console.error(`[SQL] ${req.socket.remoteAddress} failed to connect`);
          res.sendStatus(400);
        }
      }
    });
});

///////////////////////////////////////////////////////////////////////////////
// TEACHER REQUESTS
///////////////////////////////////////////////////////////////////////////////

app.post("/teacher/addSprint", (req, res) => {
  const data : {
    name : string, start : string,  end : string,  classroom_id : number, 
    teacher_id : number, techs : string[]
  } = req.body;

  //TODO: Validate data
  
  sql.query({
    sql : "INSERT INTO sprint (name, start, end, classroom_id, teacher_id)" +
          "values (?,?,?,?,?)",
    values : [data.name, data.start, data.end, data.classroom_id, data.teacher_id]
  }, (error : SQL.MysqlError) => {
    if (error) {
      console.error(`[SQL] (${req.socket.remoteAddress}) ${req.url} : `,
                    `${error.sqlMessage}`);
      res.sendStatus(400);
    } else {
     res.sendStatus(200);
    }
  });
});
