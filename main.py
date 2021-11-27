from flask import Flask, render_template, request, redirect
from flask import session
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
from flask_mail import Mail
import os
#direct import nhi ho rha hai secure_filename to utils se ho gya
from werkzeug.utils import secure_filename
import math

with open("config.json", "r") as c:
    params = json.load(c)["params"]

local_server = True
app = Flask(__name__)
#----tute 15 start-----------

#ek uni size(24) number ka binary number mil jayega
secure = os.urandom(24)
app.secret_key= secure
#-------ends-----
#---file upload karne ke liye-------
app.config['UPLOAD_FOLDER']= params['upload_filelocation']
#-------------------
app.config.update(
    #yha par kuch parameter likhege
    MAIL_SERVER = "smtp.gmail.com",
    MAIL_PORT = '465', #587
    MAIL_USE_SSL = "True",
    MAIL_USERNAME = params["gmail-username"],
    MAIL_PASSWORD = params["gmail-password"],
)
#mail-send karne ke liye hota
mail = Mail(app)

if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tagline = db.Column(db.String(50), nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(200), nullable=False)
    img_file = db.Column(db.String(25), nullable=True)
    date = db.Column(db.String(12), nullable=True)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(200), nullable=False)
    date = db.Column(db.String(12), nullable=True)

#---------------------yha par pagination lagayege----------------------
@app.route("/")
def home():
    # posts = Posts.query.filter_by().all() [0:params['no_of_posts']]
    #sabhi post ko fetch kar do
    posts = Posts.query.filter_by().all()
    # last = (len(posts)/int(params["no_of_posts"]))
    last = math.floor((len(posts)/int(params["no_of_posts"])))
    page = request.args.get("page")
    if (not str(page).isnumeric()):
        page = 1 #ye str me hai ise int me change karege
    page = int(page)
    posts = posts[(page-1)*int(params["no_of_posts"]):(page-1)*int(params["no_of_posts"]) + int(params["no_of_posts"])]
    if (page == 1):
        #previous page ko # likhuga
        prev = "#"
        # next = page+1
        next = "/?page="+ str(page+1)

    elif (page==last):
        #yha prev page =page-1 hoga
        prev = "/?page="+ str(page-1)
        #last page par next page zero hoga
        next = "#"

    else:
        #agr me midile page par hu tab
        #yha prev page =page-1 hoga
        prev = "/?page="+ str(page-1)
        next = "/?page="+ str(page+1)

    return render_template("index.html", params=params,posts= posts, prev=prev, next=next)
#----------------------------ends pagination-----------------------

@app.route("/about")
def about():
    return render_template("about.html", params=params)

#---------START 16-------------------
@app.route("/edit/<string:sno>",methods=['GET','POST'])

def edit(sno):
    if ("user" in session and session["user"] == params["admin_username"]):
        post=Posts.query.filter_by(sno=sno).first()
        return render_template("edit.html",params=params,post=post, sno=sno)

    if request.method=="POST":
        title = request.form.get('title')
        tagline = request.form.get('tagline')
        slug = request.form.get('slug')
        content = request.form.get('content')
        img_file = request.form.get('img_file')
        date = datetime.now()
        if sno=="0":
            post=Posts(title=title,tagline=tagline, slug=slug, content=content,img_file=img_file,date=date)
            db.session.add(post)
            db.session.commit()
        else:
            post=Posts.query.filter_by(sno=sno).first()
            post.title=title
            post.tagline=tagline
            post.slug=slug
            post.content=content
            post.img_file=img_file
            post.date=date

            #isko commit krna na bhule
            db.session.commit()
            return redirect("/edit/"+sno)
    post=Posts.query.filter_by(sno=sno).first()
    return render_template("edit.html",params=params,post=post, sno=sno)

#-------------ends----------------

#----------delete button ------------

@app.route("/delete/<string:sno>",methods=["POST", "GET"])
def delete(sno):
    if ("user" in session and session["user"] == params["admin_username"]):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit() #commit karege
    return redirect("/dashboard")

#-------------ends----------------#

#----------uploader button ------------
@app.route("/uploader",methods=["POST", "GET"])
def uploader():
    if ("user" in session and session["user"] == params["admin_username"]):
        if (request.method=="POST"):
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded successfully"

    #return dashboard kar dege
    return render_template("/uploader.html", params=params)
#----------------------ends uploader button----------------------------------------

#----------logout button ------------
@app.route("/logout")
def logout():
    #pop ke undar session key dalege jo hmne "user" bnai hai ex: session['user']
    if ("user" in session and session["user"] == params["admin_username"]):
        session.pop('user')
    #return dashboard kar dege
    return redirect("/dashboard")
#----------------------ends----------------------------------------


@app.route("/dashboard",methods=['GET','POST'])
def dashboard():
    if ("user" in session and session["user"] == params["admin_username"]):
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)
    if request.method=='POST':
        reg= request.form
        username = reg.get('uname')
        password = reg.get('pass')
        if not username in params["admin_username"]:
            print("username not found")
            return render_template("login.html", params=params)
        else:
            your = params["admin_username"]
        if not password==params["admin_password"]:
            print("incorrect password")
            return render_template("login.html", params=params)

        else:
            session["user"] = username
            posts = Posts.query.all()
            return render_template("dashboard.html", params=params,posts=posts)
    else:
        return render_template("login.html", params=params)
#------------------ends----------------------------



@app.route("/post/<string:post_slug>", methods=['GET','POST'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html",params=params, posts=post)

@app.route("/contact", methods=['GET','POST'] )
def contact():
    if (request.method=='POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry = Contacts(name=name, email=email, phone_num= phone, msg= message, date= datetime.now() )
        db.session.add(entry)
        db.session.commit()
        mail.send_message(
            "New massage from " + name,
            sender= email,
            recipients=[params['gmail-username']],
            body= message + "\n"+ phone
        )
    return render_template("contact.html", params=params)

if __name__ == '__main__':
    # app.run(debug=True)
    app.run(debug= True)
