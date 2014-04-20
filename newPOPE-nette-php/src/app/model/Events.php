<?php

namespace App\Model;

use Nette\Database\Context;
use Nette\Object;

class Events extends Object {

  /**
   * @var Context
   */
  private $connection;

  public function __construct(Context $connection) {
    $this->connection = $connection;
  }

  public function findPublic() {
    return $this->connection->table('events');
  }

  public function signUserTo($username, $eventId) {
    try {
      $this->connection->table('signed_user')->insert(
                       [
                         'event_id' => $eventId,
                         'username' => $username,
                       ]
      );
    } catch (\PDOException $e) {
      throw new EventsException($e->getMessage(), $e->getCode(), $e);
    }
  }

  public function isUserAttendedTo($username, $eventId) {
    return $this->connection
      ->query(
        'SELECT id FROM signed_user WHERE username = ? AND event_id = ?',
        $username, $eventId
      )->fetch();
  }
}
