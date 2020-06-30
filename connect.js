const Connection = require('tedious').Connection;
const Request = require('tedious').Request;
const TYPES = require('tedious').TYPES;
const async = require("async");
const express = require("express");
const app = express();

app.use(express.json())
app.use(express.urlencoded({extended: true}))
const port = process.env.PORT || 80;
app.use(express.static(__dirname + "/loginform"))

app.get("/", (req, res)=>{
    res.sendFile(__dirname + "/loginform/form.html")
});

app.post("/login", loginHandler);

app.post("/search", searchHandler)

// Create connection to database
const config = {
    server: 'demodblibrary.database.windows.net',
    authentication: {
        type: 'default',
        options: {
            userName: 'dbadmin', // update me
            password: 'AtZqfWjNZYzHyBm6jv3BHuD9', // update me
        }
    },
    options: {
        database: 'LIBRARY_SYSTEM'
    }
}

config.options.trustServerCertificate = true;
const connection = new Connection(config);
connection.connect()

// Attempt to connect and execute queries if connection goes through
connection.on('connect', function(err) {
    if (err) {
        console.error(err);
    } else {
        console.log('Connected')
    }
});

function searchHandler (req, res){
    const { body } = req;
    if(!body) { return res.status(403).send(JSON.stringify({
        result: false
    })); }

    const { bookname, author } = body;
    if(!bookname || !author) { return res.status(403).send(JSON.stringify({
        result: false
    })); }

    let request = new Request(
        "SELECT * FROM book WHERE bookName = '" + bookname + "' AND bookAuthor = '" + author + "'",
        function(err, rowCount) {
            if (err) {
                console.error(err)
                return res.status(500).send(JSON.stringify({
                    result: false
                }));
            } else {
                if(rowCount > 0){

                } else {
                    return res.status(200).send(JSON.stringify({
                        result: false
                    }));
                }
            }
        });



    request.on('row', function(columns) {
        let result = {};
        columns.forEach(function(column) {
            if (column.value === null) {

            } else {
                result[column.metadata.colName] = column.value;
            }
        });
        res.send(JSON.stringify({
            result
        }))
    })

    // Execute SQL statement
    connection.execSql(request);

}

function loginHandler (req, res){
    const { body } = req;
    if(!body) { return res.status(403).send("No body"); }

    const { username, password } = body;
    if(!username || !password) { return res.status(403).send("No username or password"); }

    // Read all rows from table
    let request = new Request(
        "SELECT * FROM person WHERE personUsername = '" + username + "' AND personPassword = '" + password + "'",
        function(err, rowCount) {
            if (err) {
                console.error(err)
                return res.status(500).send("Internal server error with database connection.");
            } else {
                if(rowCount > 0){
                    return res.status(200).send("Success")
                } else {
                    return res.status(200).send("Wrong username or password!")
                }
            }
        });

    // Execute SQL statement
    connection.execSql(request);
}

app.listen(port, ()=>{
    console.log("Listening at : ", port)
});