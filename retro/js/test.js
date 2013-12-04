describe("Event", function() {
  var event;
  var el;

  beforeEach(function() {
    event = new Event(1, el);
  });

  it("have an id", function() {
    expect(event.id).toBe(1);
  });

  it("can be attended", function() {
    event.setAttending(true);
    expect(event.attending).toBe(true);
  });

  it("have default value for attending", function() {
    event = new Event(1);
    expect(event.attending).toBe("nothing");
  });

  it("can change attending", function() {
    event.setAttending(true);
    expect(event.attending).toBe(true);
  });
});

describe("Dating", function() {
  var dating;
  var fakeEvent;

  beforeEach(function() {
    dating = new Dating;
    fakeEvent = { id: 1 };
    dating.events = [fakeEvent];
  });

  it("can find event by id", function() {
    expect(dating.event(1)).toBe(fakeEvent);
  });

  it("returns null for unknown event", function() {
    expect(dating.event(2)).toBe(null);
  });
});

describe("EventController", function() {
  var html;
  beforeEach(function() {
    html = $('<tr data-event-id="1"><td data-rsvp>?</td><td><button data-action="true">Ano</button><button data-action="false">Ne</button></td></tr>');

    var store = {};
    spyOn(localStorage, 'getItem').andCallFake(function (key) {
      var value = store[key];
      return value ? value : null;
    });

    spyOn(localStorage, 'setItem').andCallFake(function (key, value) {
      return store[key] = value + '';;
    });

    spyOn(localStorage, "clear").andCallFake(function () {
      store = {};
    });
  });

  afterEach(function() {
    $('[data-event-id]').remove();
  });

  it('works', function() {
    html.appendTo('body');
    var rsvp = $('[data-rsvp]');

    expect(rsvp.html()).toBe('?');

    Dating.prototype.start();

    expect(rsvp.html()).toBe('nothing');
    expect(localStorage.getItem(1)).toBe(null);
    $('[data-action=true]').click();
    expect(rsvp.html()).toBe('true');
    expect(localStorage.getItem(1)).toBe('true');
    $('[data-action=false]').click();
    expect(rsvp.html()).toBe('false');
    expect(localStorage.getItem(1)).toBe('false');
  });

  it('works after reload', function() {
    localStorage.setItem(1, "true");
    html.appendTo('body');
    Dating.prototype.start();

    var rsvp = $('[data-rsvp]');
    expect(rsvp.html()).toBe('true');
  });
});
