<?php

namespace App\Model;

use Nette\Http\SessionSection;
use Nette\Object;

class SignedUser extends Object {

  /** @var SessionSection */
  private $session;

  public function __construct(SessionSection $session) {
    $this->session = $session;
  }

  public function isSigned() {
    return empty($this->session->username) ? false : true;
  }

  public function sign($name) {
    $this->session->username = $name;
  }

  public function getName() {
    return $this->session->username;
  }
}
