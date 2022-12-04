import jwt, datetime, os
from flask import Flask, request
from flask_mysqldb import MySQL

server = Flask(__name__)
mysql = MySQL(server)

# config
server.config["MYSQL_HOST"] = os.environ["MYSQL_HOST"]
server.config["MYSQL_USER"] = os.environ["MYSQL_USER"]
server.config["MYSQL_PASSWORD"] = os.environ["MYSQL_PASSWORD"]
server.config["MYSQL_DB"] = os.environ["MYSQL_DB"]
server.config["MYSQL_PORT"] = os.environ["MYSQL_PORT"]

@server.route("/login", methods=["POST"])
def login():
    auth = request.authorization
    # request.authorization will use Basic Auth to log in.
    # Gets auth.username and .password attributes
    # If none are supplied...
    if not auth:
        return "missing credentials", 401

    # check db for username and password
    cursor = mysql.connection.cursor()
    result = cursor.execute(
            "SELECT email, password FROM user WHERE email=%s", (auth.username,)
            )

    # result returns an array of rows
    if result > 0:
        user_row = cursor.fetchone()
        email = user_row[0]
        password = user_row[1]

        if auth.username != email or auth.password != password:
            return "invalid credentials", 401
        else:
            return createJWT(auth.username, os.environ.get("JWT_SECRET"), True)
    # User doesn't exist in db
    else:
        return "invalid credentials", 401

