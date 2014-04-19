import flask
import rsmt.port.web.views as views


class RsmtFlaskApp(flask.Flask):
    def __init__(self, app, *args, **kwargs):
        super(RsmtFlaskApp, self).__init__(*args, **kwargs)
        self.app = app


def create_app(app, secret_key):
    flask_app = RsmtFlaskApp(app, __name__, static_folder='static', template_folder='templates')
    flask_app.config['SECRET_KEY'] = secret_key
    flask_app.register_blueprint(views.app)
    flask_app.jinja_env.filters['date'] = _jinja2_filter_date
    flask_app.jinja_env.filters['datetime'] = _jinja2_filter_datetime
    flask_app.jinja_env.filters['time'] = _jinja2_filter_time

    return flask_app


def _jinja2_filter_date(date, fmt=None):
    format = fmt or '%d.%m.%Y'
    return date.strftime(format)


def _jinja2_filter_datetime(date, fmt=None):
    format = fmt or '%d.%m.%Y %H:%M'
    return date.strftime(format)


def _jinja2_filter_time(date, fmt=None):
    format = fmt or '%H:%M'
    return date.strftime(format)