import docopt
import kaptan
from rsmt.application import ApplicationRegistry
from rsmt.port.db import PgInfrastructureRegistry
import rsmt.port.web.app as web


def create_application(config):

    infrastructure = PgInfrastructureRegistry(
            host=config.get('db.host'),
            port=config.get('db.port'),
            user=config.get('db.user'),
            password=config.get('db.password'),
            database=config.get('db.database')
    )
    return ApplicationRegistry(
        infrastructure=infrastructure
    )

def shell(config):
    import IPython

    app = create_application(config)
    IPython.embed(user_ns=dict(
        app=app,
        event_service=app.event_service,
        attendance_service=app.attendance_service
    ))


def create_db(config):
    app = create_application(config)
    app._infrastructure.db_service.create_database()

def runserver(config):
    app = create_application(config)

    flask_app = web.create_app(app, secret_key=config.get('web.secret_key', 'TOP SECRET'))
    flask_app.run(debug=True)


def main():
    '''
    Rubysentiments

    Usage:
      rsmt shell [options]
      rsmt create_db [options]
      rsmt runserver [options]

    Options:
      -h, --help                 Show this screen.
      -c, --config PATH          Path to configuration file
      -H, --host HOST            Host [default: localhost]
      -p, --port PORT            Port [default: 5432]
      -U, --user USERNAME        Username
      -W, --password PASSWD      Password
      -d, --database DB          Database [default: rsmt]
    '''
    arguments = docopt.docopt(main.__doc__)

    config = kaptan.Kaptan('ini')


    if arguments['--config']:
        config.import_config(arguments['--config'])

    if arguments['--host']:
        config.configuration_data.setdefault('db', {})['host'] = arguments['--host']

    if arguments['--port']:
        config.configuration_data.setdefault('db', {})['port'] = arguments['--port']

    if arguments['--user']:
        config.configuration_data.setdefault('db', {})['user'] = arguments['--user']

    if arguments['--password']:
        config.configuration_data.setdefault('db', {})['password'] = arguments['--password']

    if arguments['--database']:
        config.configuration_data.setdefault('db', {})['database'] = arguments['--database']

    if arguments['shell']:
        shell(config)
        # create_application(config)
    elif arguments['create_db']:
        create_db(config)
    elif arguments['runserver']:
        runserver(config)


if __name__ == '__main__':
    main()