import os
from flask import Flask, render_template, redirect, url_for, flash, session, request
from flask_mysqldb import MySQL
from flask_bcrypt import Bcrypt
from wtforms import StringField, PasswordField, DateField, TimeField, SelectField
from flask_wtf import FlaskForm
from wtforms.validators import InputRequired, Length, EqualTo
from wtforms import SubmitField
import MySQLdb.cursors


app = Flask(__name__)
app.secret_key = os.urandom(24)

# MySQL Config
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'healthassist'

# Initialize MySQL and Bcrypt
mysql = MySQL(app)
bcrypt = Bcrypt(app)


class AppointmentForm(FlaskForm):
    name = StringField('Patient Name', validators=[InputRequired(), Length(min=2, max=100)])
    doctor_id = SelectField('Select Doctor', coerce=int, validators=[InputRequired()])
    appointment_type = SelectField('Appointment Type', choices=[('Google Meet', 'Google Meet'), ('in person', 'In Person')], validators=[InputRequired()])
    date = DateField('Select Date', format='%Y-%m-%d', validators=[InputRequired()])
    time = TimeField('Select Time', format='%H:%M', validators=[InputRequired()])
    submit = SubmitField('Book Appointment')

# Registration Form (removed Email validator)
class RegisterForm(FlaskForm):
    username = StringField('Username', validators=[InputRequired(), Length(min=4, max=25)])
    email = StringField('Email', validators=[InputRequired()])  # Removed Email validator
    password = PasswordField('Password', validators=[
        InputRequired(),
        Length(min=6),
        EqualTo('confirm', message='Passwords must match')
    ])
    confirm = PasswordField('Confirm Password')
    phone = StringField('Phone Number', validators=[InputRequired(), Length(min=10, max=15)])  # Added phone field
    submit = SubmitField('Register')

# Login Form (removed Email validator)
class LoginForm(FlaskForm):
    email = StringField('Email', validators=[InputRequired()])  # Removed Email validator
    password = PasswordField('Password', validators=[InputRequired()])
    submit = SubmitField('Login')

# Home Page (with login and register buttons)
@app.route('/')
def home():
    return render_template('home.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')


@app.route('/aftercontact')
def contact1():
    return render_template('after_contact.html', username=session['username'])


# Register Page
@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm()
    if form.validate_on_submit():
        username = form.username.data
        email = form.email.data
        password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        phone = form.phone.data

        # Insert into MySQL
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users(username, email, password, phone) VALUES (%s, %s, %s, %s)",
                    (username, email, password, phone))
        mysql.connection.commit()
        cur.close()

        flash('You are now registered and can log in', 'success')
        return redirect(url_for('login'))

    return render_template('register.html', form=form)

# Login Page
@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        email = form.email.data
        password = form.password.data

        # MySQL Query to check email
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cur.fetchone()
        cur.close()

        if user and bcrypt.check_password_hash(user['password'], password):
            session['logged_in'] = True
            session['username'] = user['username']
            session['user_id'] = user['user_id']
            return redirect(url_for('index'))
        else:
            flash('Invalid login. Please check email and password', 'danger')

    return render_template('login.html', form=form)

# Index Page (welcome page after login)
@app.route('/index')
def index():
    if 'logged_in' in session:
        return render_template('index.html', username=session['username'])
    return redirect(url_for('login'))


# Route to display exercise categories
@app.route('/exercise')
def exercise():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM exercise_categories")
    categories = cur.fetchall()
    cur.close()
    return render_template('exercise.html', categories=categories)

# Route to display exercises within a selected category
@app.route('/category/<int:category_id>')
def exercises_by_category(category_id):
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM exercises WHERE category_id = %s", (category_id,))
    exercises = cur.fetchall()

    cur.execute("SELECT category_name FROM exercise_categories WHERE category_id = %s", (category_id,))
    category_name = cur.fetchone()['category_name']

    cur.close()
    return render_template('category_exercises.html', exercises=exercises, category_name=category_name)


# Route to display exercise categories
@app.route('/afterexercise')
def exercise1():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM exercise_categories")
    categories = cur.fetchall()
    cur.close()
    return render_template('after_exercise.html', username=session['username'], categories=categories)

# Route to display exercises within a selected category
@app.route('/aftercategory/<int:category_id>')
def exercises_by_category1(category_id):
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM exercises WHERE category_id = %s", (category_id,))
    exercises = cur.fetchall()

    cur.execute("SELECT category_name FROM exercise_categories WHERE category_id = %s", (category_id,))
    category_name = cur.fetchone()['category_name']

    cur.close()
    return render_template('after_category_exercise.html', exercises=exercises, username=session['username'], category_name=category_name)


@app.route('/doctor')
def doctors():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM doctors")
    doctors = cur.fetchall()  # Fetching all doctor records
    cur.close()
    return render_template('doctor.html', doctors=doctors)

@app.route('/afterdoctor')
def doctors1():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM doctors")
    doctors = cur.fetchall()  # Fetching all doctor records
    cur.close()
    return render_template('after_doctor.html', username=session['username'], doctors=doctors)




 # Import the AppointmentForm class

@app.route('/appointment', methods=['GET', 'POST'])
def appointment():
    if 'logged_in' not in session:
        flash('Please log in to book an appointment', 'warning')
        return redirect(url_for('login'))

    form = AppointmentForm()

    # Populate the doctor dropdown
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT doctor_id, name FROM doctors")
    doctors = cur.fetchall()
    form.doctor_id.choices = [(doctor['doctor_id'], doctor['name']) for doctor in doctors]
    cur.close()

    if form.validate_on_submit():
        name = form.name.data
        doctor_id = form.doctor_id.data
        appointment_type = form.appointment_type.data
        date = form.date.data
        time = form.time.data

        user_id = session.get('user_id')  # Make sure you set this in your login logic

        # Insert appointment into the database
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO appointments (user_id, doctor_id, name, appointment_type, 	appointment_date, appointment_time) VALUES (%s, %s, %s, %s, %s, %s)",
                    (user_id, doctor_id, name, appointment_type, date, time))
        mysql.connection.commit()
        cur.close()

        flash('Your appointment has been booked successfully!', 'success')
        return redirect(url_for('appointment_history'))

    return render_template('appointment.html', username=session['username'] , form=form)


@app.route('/booking-history')
def appointment_history():
    if 'logged_in' not in session:
        flash('Please log in to view your appointment history', 'warning')
        return redirect(url_for('login'))

    user_id = session.get('user_id')

    # Fetch appointment history
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM appointments WHERE user_id = %s", [user_id])
    appointments = cur.fetchall()
    cur.close()

    return render_template('appointment_history.html', username=session['username'], appointments=appointments)


@app.route('/save_chat', methods=['POST'])
def save_chat():
    if 'logged_in' not in session:
        return "User not logged in", 403

    data = request.get_json()
    user_message = data.get('user_message')
    assistant_response = data.get('assistant_response')
    user_id = session['user_id']  # Get the logged-in user's ID

    # Insert chat history into MySQL
    cur = mysql.connection.cursor()
    cur.execute("""
        INSERT INTO chat_history (user_id, user_message, assistant_response) 
        VALUES (%s, %s, %s)
    """, (user_id, user_message, assistant_response))
    mysql.connection.commit()
    cur.close()

    return "Chat history saved", 200


@app.route('/chat_history')
def chat_history():
    if 'logged_in' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']

    # Fetch chat history from MySQL
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM chat_history WHERE user_id = %s ORDER BY timestamp DESC", (user_id,))
    chats = cur.fetchall()
    cur.close()

    return render_template('chat_history.html', chats=chats, username=session['username'])


# Logout Route
@app.route('/logout')
def logout():
    session.clear()
    flash('You have been logged out', 'success')
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(debug=True)
