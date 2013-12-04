function Event(id, dom) {
  this.id = id;
  this.attending = "nothing";
  this.setAttending = function(value) {
    this.attending = value;
    $(document).trigger('dating:change:' + id, this);
  }
};

function Dating() {
  if ( arguments.callee._singletonInstance )
    return arguments.callee._singletonInstance;
  arguments.callee._singletonInstance = this;

  this.events = [];
  this.event = function(id) {
    var event = this.events.filter(function(e) { return e.id == id.toString() })[0];
    return event ? event : null;
  }
};

function EventController(event, element) {
  var rsvpElement = element.find('[data-rsvp]');
  var setValue = function(value) {
    rsvpElement.html(value);
  }

  this.element = element;
  this.event = event;

  this.loadValue = function() {
    var value = localStorage.getItem(event.id)
    if(value) event.attending = value;
  }

  this.bindController = function() {
    element.find('button').on('click', function() {
      var value = $(this).data('action');
      event.setAttending(value);
      setValue(value);
    });

    $(document).on('dating:change:' + this.event.id, function(e, event) {
      localStorage.setItem(event.id, event.attending);
    });
  };

  this.loadValue();
  this.bindController();
  setValue(this.event.attending);
};

var dating;

Dating.prototype.start = function() {
  dating = new Dating();
  $('[data-event-id]').each(function() {
    var el = $(this);
    var id = el.data('event-id');
    var event = new Event(id, el);
    var controller = new EventController(event, el);
    dating.events.push(event);
  });
};

