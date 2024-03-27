import * as fs from "node:fs";
import express from "express";
import cors from "cors";
import * as SQL from "mysql";
import { sha256 } from "js-sha256";
import { generate } from "generate-password";

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
// ADMIN REQUESTS
///////////////////////////////////////////////////////////////////////////////

app.post("/admin/addPeople", (req, res) => {
  const data : { 
    firstName : string, lastName : string, email : string, password : string,
    isTeacher ?: string
  } = req.body;

  const valid = /^[a-zA-Z0-9._%+-]+@(edu\.)?esiee-it\.fr$/.exec(data.email);
  if (!valid) { res.sendStatus(400); return; }
  
  const password = generate({numbers: true, length: 10});
  const hash = sha256(password);
  
  if (fs.existsSync("tmp/")) {
    if (fs.existsSync("tmp/password.txt")) {
      fs.appendFileSync("tmp/password.txt", `${data.email} ${password}\n`);
    } else {
      fs.writeFileSync("tmp/password.txt", `${data.email} ${password}\n`);
    }
  } else {
    fs.mkdirSync("tmp");
    fs.writeFileSync("tmp/password.txt", `${data.email} ${password}\n`);
  }
  
  let isTeacher : boolean = false;
  if (data.isTeacher) isTeacher = true;
  
  sql.query({
    sql : "INSERT INTO user (first_name, last_name, email, password, is_teacher)" +
          "VALUES (?,?,?,?,?)",
    values : [data.firstName, data.lastName, data.email, hash, isTeacher]
  }, (error : SQL.MysqlError) => {
    if (error) {
      console.error(`[SQL] (${req.socket.remoteAddress}) ${req.url} : `,
                    `${error.sqlMessage}`);
      res.sendStatus(400);
    } else {
      console.log(`[SQL] ${data.firstName} ${data.lastName} was created`);
      res.sendStatus(200);
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

  sql.query({
    sql : "SELECT is_teacher, first_name, last_name FROM user WHERE user.id = ?",
    values : [data.teacher_id]
  }, (error : SQL.MysqlError, results : Array<any>) => {
    if (error) {
      console.error(`[SQL] (${req.socket.remoteAddress}) ${req.url} : `,
                    `${error.sqlMessage}`);
      res.sendStatus(400);
      return;
    }
      
    if (results && results[0] == 0) {
      console.error(`[SQL] ${results[1]} ${results[2]} is not allowed to do that`);
      res.sendStatus(400);
      return;
    };
      
    sql.query({
      sql : "INSERT INTO sprint (name, start, end, classroom_id, teacher_id)" +
            "VALUES (?,?,?,?,?)",
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
});
