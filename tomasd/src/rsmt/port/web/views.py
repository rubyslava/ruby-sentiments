import flask
from werkzeug.local import LocalProxy

app = flask.Blueprint('event', __name__)

event_service = LocalProxy(lambda: flask.current_app.app.event_service)
attendance_service = LocalProxy(
    lambda: flask.current_app.app.attendance_service)


@app.route('/')
def index():
    events = event_service.list_events(
        current_user_email=get_current_user_email()
    )

    return flask.render_template('events.html', events=events)


@app.route('/event/<int:event_id>/participate', methods=['POST'])
def participate(event_id):
    email = flask.request.form['email']

    attendance_service.attend_event_by_user(
        event_id=event_id,
        user_email=email,
    )

    set_current_user_email(email)
    return flask.redirect(flask.url_for('.index'))


def get_current_user_email():
    return flask.session.get('email')


def set_current_user_email(email):
    flask.session['email'] = email
